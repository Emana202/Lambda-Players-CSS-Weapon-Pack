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
        dynLight.DieTime = ( CurTime() + 0.1 )
    end )
end

local IsValid = IsValid
local random = math.random
local ents_Create = ents.Create
local SimpleTimer = timer.Simple
local ipairs = ipairs
local FindInSphere =  ents.FindInSphere
local ignorePlys = GetConVar( "ai_ignoreplayers" )
local flashColor = Color( 255, 255, 255 )
local angularVel = Vector( 600, 0, 0 )

local ignoreThrower = CreateLambdaConvar( "lambdaplayers_weapons_flashbang_ignorethrower", 1, true, false, false, "If thrown flashbang shouldn't blind its Lambda thrower", 0, 1, { type = "Bool", name = "CSS Flashbang - Don't Flash Thrower", category = "Weapon Utilities" } )

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_grenade_flashbang = {
		model = "models/weapons/w_eq_flashbang.mdl",
		bonemerge = true,
		holdtype = "grenade",
		prettyname = "Flashbang",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_grenade_flashbang",

        islethal = true,
		keepdistance = 600,
		attackrange = 1000,
		clip = 1,

        OnAttack = function( self, wepent, target )
            local grenade = ents_Create( "prop_physics" )
            if !IsValid( grenade ) then return true end

            local srcPos = wepent:GetPos()
            self.l_WeaponUseCooldown = CurTime() + random( 4, 8 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

            grenade:SetModel( "models/weapons/w_eq_flashbang.mdl" )
            grenade:SetPos( srcPos )
            grenade:SetOwner( self )
            grenade:Spawn()

            grenade:SetGravity( 0.4 )
            grenade:SetFriction( 0.2 )
            grenade:SetElasticity( 0.45 )

            grenade.l_GrenadeBounceSound = "Flashbang.Bounce"

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( ( target:GetPos() - srcPos ):GetNormalized() * 750 )

                angularVel.y = random( -1200, 1200 )
                phys:SetAngleVelocity( angularVel )
            end

            SimpleTimer( 1.5, function()
                if !IsValid( grenade ) then return end
                
                local owner = grenade:GetOwner()
                if !IsValid( owner ) then return end

                local grenPos = grenade:GetPos()
                for _, victim in ipairs( FindInSphere( grenPos, 1500 ) ) do
                    if victim == owner and ignoreThrower:GetBool() or !IsValid( victim ) or !victim.IsLambdaPlayer and !victim:IsPlayer() or !owner:CanTarget( victim ) or !victim:VisibleVec( grenPos ) then continue end
                    local eyePos = ( victim.IsLambdaPlayer and victim:GetAttachmentPoint( "eyes" ).Pos or victim:EyePos() )                            

                    local adjDmg = ( 4 - ( eyePos:Distance( grenPos ) * 0.0026666666666667 ) )
                    if adjDmg <= 0 then continue end

                    local lookDir = ( victim.IsLambdaPlayer and victim:GetForward() or victim:GetAimVector() )
                    local los = ( grenPos - eyePos )

                    local dotProduct = lookDir:Dot( los:GetNormalized() )
                    local fadeTime, fadeHold = adjDmg, ( adjDmg * 0.25 )
                    if dotProduct >= 0.5 then
                        fadeTime = ( adjDmg * 2.5 )
                        fadeHold = ( adjDmg * 1.25 )
                    elseif dotProduct >= -0.5 then
                        fadeTime = ( adjDmg * 1.75 )
                        fadeHold = ( adjDmg * 0.8 )
                    end
                    fadeTime = ( fadeTime * 0.4 )
                    fadeHold = ( fadeHold * 0.4 )

                    if victim.IsLambdaPlayer then
                        fadeTime = ( fadeTime * 1.75 )
                        if fadeTime < 1 then continue end

                        victim.l_BlindedByFlashbang = true
                        victim:AddGesture( ACT_HL2MP_FIST_BLOCK, false )

                        victim:SimpleTimer( fadeTime, function() 
                            victim:RemoveGesture( ACT_HL2MP_FIST_BLOCK )
                            victim.l_BlindedByFlashbang = false

                            if !victim:Alive() or !victim:IsPanicking() then return end
                            victim:CancelMovement()

                            if owner == victim or !LambdaIsValid( owner ) then return end
                            victim:AttackTarget( owner, true )
                        end, true )

                        victim:CancelMovement()
                        victim:SetEnemy( NULL )
                        victim:RetreatFrom( nil, fadeTime )
                        continue
                    end

                    flashColor.a = ( ( dotProduct < 0.5 or dotProduct < -0.5 ) and 200 or 255 )
                    victim:ScreenFade( SCREENFADE.IN, flashColor, fadeTime, fadeHold )

                    local dist = los:Length()
                    local strength = ( dist < 600 and 35 or ( dist < 800 and 36 or ( dist < 1000 and 37 ) ) )
                    if strength then victim:SetDSP( strength, false ) end
                end

                net.Start( "lambdacss_flashbangexplode" )
                    net.WriteUInt( grenade:EntIndex(), 13 )
                    net.WriteVector( grenPos )
                net.Broadcast()

                grenade:EmitSound( "Flashbang.Explode" )
                grenade:Remove()
            end )

            return true
        end
	}
} )