local IsValid = IsValid
local CurTime = CurTime
local random = math.random
local ents_Create = ents.Create
local EffectData = EffectData
local SimpleTimer = timer.Simple
local util_Effect = util.Effect
local util_BlastDamage = util.BlastDamage
local angularVel = Vector( 600, 0, 0 )

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

        OnAttack = function( self, wepent, target )
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

            grenade.l_GrenadeBounceSound = "HEGrenade.Bounce"
            grenade.l_UseLambdaDmgModifier = true

            grenade.l_Lambdified = true
            grenade.l_UseLambdaDmgModifier = true
            grenade.l_killiconname = wepent.l_killiconname

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( ( target:GetPos() - srcPos ):GetNormalized() * 750 )

                angularVel.y = random( -1200, 1200 )
                phys:SetAngleVelocity( angularVel )
            end

            SimpleTimer( 1.5, function()
                if !IsValid( grenade ) then return end
                local grenPos = grenade:GetPos()

                local effectData = EffectData()
                effectData:SetOrigin( grenPos )
                util_Effect( "Explosion", effectData, true, true )

                local owner = grenade:GetOwner()
                util_BlastDamage( grenade, ( IsValid( owner ) and owner or grenade ), grenPos, 350, 100 )

                grenade:Remove()
            end )

            return true
        end
	}
} )