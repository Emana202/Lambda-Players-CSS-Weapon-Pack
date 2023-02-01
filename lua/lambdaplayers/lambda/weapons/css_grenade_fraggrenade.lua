local IsValid = IsValid
local CurTime = CurTime
local random = math.random
local ents_Create = ents.Create
local hook_Add = hook.Add
local hook_Remove = hook.Remove
local EffectData = EffectData
local SimpleTimer = timer.Simple
local util_Effect = util.Effect
local util_BlastDamage = util.BlastDamage

local angularVel = Vector( 600, 0, 0 )
local bounceSnds = {
    [ "physics/metal/weapon_impact_hard1.wav" ] = true,
    [ "physics/metal/weapon_impact_hard2.wav" ] = true,
    [ "physics/metal/weapon_impact_hard3.wav" ] = true
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_grenade_fraggrenade = {
		model = "models/weapons/w_eq_fraggrenade.mdl",
		bonemerge = true,
		holdtype = "grenade",
		prettyname = "HE Grenade",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_grenade_fraggrenade",

        islethal = true,
		keepdistance = 600,
		attackrange = 800,
		clip = 1,

        callback = function( self, wepent, target )
            local grenade = ents_Create( "prop_physics" )
            if !IsValid( grenade ) then return true end

            local srcPos = wepent:GetPos()
            self.l_WeaponUseCooldown = CurTime() + random( 2.0, 3.0 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

            grenade:SetModel( "models/weapons/w_eq_fraggrenade.mdl" )
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
            local hookName = "LambdaCSS_HEGrenadeSounds_" .. entIndex
            hook_Add( "EntityEmitSound", hookName, function( sndData )
                if IsValid( grenade ) then
                    local sndPos = sndData.Pos
                    if sndPos and bounceSnds[ sndData.SoundName ] and grenade:GetPos():DistToSqr( sndPos ) <= ( 128 * 128 ) then 
                        grenade:EmitSound( "HEGrenade.Bounce" )
                        return false
                    end
                else
                    hook_Remove( "EntityEmitSound", hookName )
                end
            end )
            grenade:CallOnRemove( "LambdaCSS_OnHEGrenadeRemoved_" .. entIndex, function()
                hook_Remove( "EntityEmitSound", hookName )
            end )

            SimpleTimer( 1.5, function()
                if !IsValid( grenade ) then return end
                
                local effectData = EffectData()
                effectData:SetOrigin( grenade:GetPos() )
                util_Effect( "Explosion", effectData, true, true )

                local owner = grenade:GetOwner()
                util_BlastDamage( ( IsValid( owner ) and owner:GetWeaponENT() or grenade ), ( IsValid( owner ) and owner or grenade ), grenade:GetPos(), 350, 100 )

                grenade:Remove()
            end )

            return true
        end
	}
} )