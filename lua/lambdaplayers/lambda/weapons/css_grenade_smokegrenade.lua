local IsValid = IsValid
local CurTime = CurTime
local ipairs = ipairs
local random = math.random
local ents_Create = ents.Create
local hook_Add = hook.Add
local hook_Remove = hook.Remove
local SimpleTimer = timer.Simple
local angularVel = Vector( 600, 0, 0 )

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_grenade_smokegrenade = {
		model = "models/weapons/w_eq_smokegrenade.mdl",
		bonemerge = true,
		holdtype = "grenade",
		prettyname = "Smoke Grenade",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_grenade_flashbang",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,
		clip = 1,

        OnAttack = function( self, wepent, target )
            local grenade = ents_Create( "prop_physics" )
            if !IsValid( grenade ) then return true end

            local srcPos = wepent:GetPos()
            self.l_WeaponUseCooldown = CurTime() + random( 10, 15 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

            grenade:SetModel( "models/weapons/w_eq_smokegrenade.mdl" )
            grenade:SetPos( srcPos )
            grenade:SetOwner( self )
            grenade:Spawn()

            grenade:SetGravity( 0.4 )
            grenade:SetFriction( 0.2 )
            grenade:SetElasticity( 0.45 )

            grenade.l_GrenadeBounceSound = "SmokeGrenade.Bounce"

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( ( target:GetPos() - srcPos ):GetNormalized() * 750 + self.loco:GetVelocity() )

                angularVel.y = random( -1200, 1200 )
                phys:SetAngleVelocity( angularVel )
            end

            local smokeParticles = {}
            local explodeTime = ( CurTime() + 1.5 )
            local thinkHook = "LambdaCSS_SmokeGrenadeThink_" .. grenade:EntIndex()

            hook_Add( "Think", thinkHook, function()
                if !IsValid( grenade ) then hook_Remove( "Think", thinkHook ) return end
                if CurTime() < explodeTime then return end

                if grenade:GetVelocity():Length() > 0.1 then
                    explodeTime = ( CurTime() + 0.2 )
                    return
                end

                local grenPos = grenade:GetPos()
                for i = 1, 5 do
                    local smokeEnt = ents_Create( "env_particlesmokegrenade" )
                    smokeEnt:SetPos( grenPos )
                    smokeEnt:SetSaveValue( "m_CurrentStage", 1 )
                    smokeEnt:Spawn()
                    smokeEnt:Activate()
                    smokeParticles[ #smokeParticles + 1] = smokeEnt
                end

                grenade:EmitSound( "BaseSmokeEffect.Sound" )
                grenade:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
                LambdaCSS_GrenadeSmokes[ grenade ] = { grenPos, ( CurTime() + 20 ) }
                if IsValid( phys ) then phys:Sleep() end

                SimpleTimer( 25, function()
                    if IsValid( grenade ) then grenade:Remove() end
                    for _, smokeEnt in ipairs( smokeParticles ) do if IsValid( smokeEnt ) then smokeEnt:Remove() end end
                end )

                hook_Remove( "Think", thinkHook )
            end )

            return true
        end
	}
} )