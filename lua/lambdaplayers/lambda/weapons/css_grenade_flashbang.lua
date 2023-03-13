local CurTime = CurTime
local net = net

if ( SERVER ) then
    util.AddNetworkString( "lambdacss_flashbangexplode" )
end

if ( CLIENT ) then
    local CreateDynamicLight = DynamicLight
    net.Receive( "lambdacss_flashbangexplode", function() 
        local dynLight = CreateDynamicLight( net.ReadUInt( 13 ) )
        if !dynLight then return end
        
        dynLight.pos = net.ReadVector()
        dynLight.r = 255
        dynLight.g = 255
        dynLight.b = 255
        dynLight.brightness = 2
        dynLight.Decay = 768
        dynLight.Size = 400
        dynLight.DieTime = CurTime() + 0.1
    end )
end

local IsValid = IsValid
local random = math.random
local ents_Create = ents.Create
local hook_Add = hook.Add
local hook_Remove = hook.Remove
local SimpleTimer = timer.Simple
local ipairs = ipairs
local ents_FindInSphere =  ents.FindInSphere
local ignorePlys = GetConVar( "ai_ignoreplayers" )

local ignoreThrower = CreateLambdaConvar( "lambdaplayers_weapons_flashbang_ignorethrower", 1, true, false, false, "If thrown flashbang shouldn't blind its Lambda thrower", 0, 1, { type = "Bool", name = "CSS Flashbang - Don't Flash Thrower", category = "Weapon Utilities" } )

local flashColor = Color( 255, 255, 255 )
local angularVel = Vector( 600, 0, 0 )
local bounceSnds = {
    [ "physics/metal/weapon_impact_hard1.wav" ] = true,
    [ "physics/metal/weapon_impact_hard2.wav" ] = true,
    [ "physics/metal/weapon_impact_hard3.wav" ] = true
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_grenade_flashbang = {
		model = "models/weapons/w_eq_flashbang.mdl",
		bonemerge = true,
		holdtype = "grenade",
		prettyname = "Flashbang",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_grenade_flashbang",

        islethal = true,
		keepdistance = 500,
		attackrange = 1000,
		clip = 1,

        OnAttack = function( self, wepent, target )
            local grenade = ents_Create( "prop_physics" )
            if !IsValid( grenade ) then return true end

            local srcPos = wepent:GetPos()
            self.l_WeaponUseCooldown = CurTime() + random( 4.0, 8.0 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

            grenade:SetModel( "models/weapons/w_eq_flashbang.mdl" )
            grenade:SetPos( srcPos )
            grenade:SetOwner( self )
            grenade:Spawn()

            grenade:SetGravity( 0.4 )
            grenade:SetFriction( 0.2 )
            grenade:SetElasticity( 0.45 )

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( ( target:GetPos() - srcPos ):GetNormalized() * 750 )

                angularVel.y = random( -1200, 1200 )
                phys:SetAngleVelocity( angularVel )
            end

            local entIndex = grenade:EntIndex()
            local hookName = "LambdaCSS_FlashGrenadeSounds_" .. entIndex
            hook_Add( "EntityEmitSound", hookName, function( sndData )
                if IsValid( grenade ) then
                    local sndPos = sndData.Pos
                    if sndPos and bounceSnds[ sndData.SoundName ] and grenade:GetPos():DistToSqr( sndPos ) <= ( 128 * 128 ) then 
                        grenade:EmitSound( "Flashbang.Bounce" )
                        return false
                    end
                else
                    hook_Remove( "EntityEmitSound", hookName )
                end
            end )
            grenade:CallOnRemove( "LambdaCSS_OnFlashGrenadeRemoved_" .. entIndex, function()
                hook_Remove( "EntityEmitSound", hookName )
            end )

            SimpleTimer( 1.5, function()
                if !IsValid( grenade ) then return end
                
                local owner = grenade:GetOwner()
                local grenPos = grenade:GetPos()
                for _, v in ipairs( ents_FindInSphere( grenPos, 1500 ) ) do
                    if !LambdaIsValid( v ) or !v.IsLambdaPlayer and ( !v:IsPlayer() or !v:Alive() or ignorePlys:GetBool() ) or !v:VisibleVec( grenPos ) then continue end
                    if IsValid( owner ) and ( v == owner and ignoreThrower:GetBool() or !owner:CanTarget( v ) ) then continue end

                    local eyePos = ( v.IsLambdaPlayer and v:GetAttachmentPoint( "eyes" ).Pos or v:EyePos() )                            
                    local adjustedDamage = ( 4 - ( eyePos:Distance( grenPos ) * ( 4 / 1500 ) ) )
                    if adjustedDamage <= 0 then continue end

                    local lookDir = ( v.IsLambdaPlayer and v:GetForward() or v:GetAimVector() )
                    local lineOfSight = ( grenPos - eyePos )
                    local dotProduct = lookDir:Dot( lineOfSight:GetNormalized() )
                        
                    local fadeTime = adjustedDamage * 1.0
                    local fadeHold = adjustedDamage * 0.25
                    if dotProduct >= 0.5 then
                        fadeTime = adjustedDamage * 2.5
                        fadeHold = adjustedDamage * 1.25
                    elseif dotProduct >= -0.5 then
                        fadeTime = adjustedDamage * 1.75
                        fadeHold = adjustedDamage * 0.8
                    end
                    fadeTime = fadeTime * 0.4
                    fadeHold = fadeHold * 0.4

                    if v.IsLambdaPlayer then
                        fadeTime = fadeTime * 1.75
                        if fadeTime < 1.0 then continue end

                        v:AddGesture( ACT_HL2MP_FIST_BLOCK, false )

                        local eneMemory = ( v:InCombat() and v:GetEnemy() or owner )
                        v:SimpleTimer( fadeTime, function() 
                            v:RemoveGesture( ACT_HL2MP_FIST_BLOCK )
                            if !v:IsPanicking() then return end
                            
                            v:CancelMovement()

                            if eneMemory == v or !LambdaIsValid( eneMemory ) then return end
                            v:AttackTarget( eneMemory, true )
                        end, true )

                        v:CancelMovement()
                        v:SetEnemy( NULL )
                        
                        v:RetreatFrom( nil, fadeTime )
                    elseif v:IsPlayer() then
                        local startingAlpha = ( ( dotProduct < 0.5 or dotProduct < -0.5 ) and 200 or 255 )
                        flashColor.a = startingAlpha
                        v:ScreenFade( SCREENFADE.IN, flashColor, fadeTime, fadeHold )

                        local dist = lineOfSight:Length()
                        local strength = ( dist < 600 and 35 or ( dist < 800 and 36 or ( dist < 1000 and 37 or nil ) ) )
                        if strength != nil then v:SetDSP( strength, false ) end
                    end
                end

                net.Start( "lambdacss_flashbangexplode" )
                    net.WriteUInt( entIndex, 13 )
                    net.WriteVector( grenPos )
                net.Broadcast()

                grenade:EmitSound( "Flashbang.Explode" )
                grenade:Remove()
            end )

            return true
        end
	}
} )