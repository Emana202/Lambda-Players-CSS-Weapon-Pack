local IsValid = IsValid
local CurTime = CurTime
local ipairs = ipairs
local random = math.random
local ents_Create = ents.Create
local angularVel = Vector( 600, 0, 0 )
local SimpleTimer = timer.Simple

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
            local grenade = ents_Create( "base_gmodentity" )
            if !IsValid( grenade ) then return true end

            local srcPos = wepent:GetPos()
            self.l_WeaponUseCooldown = CurTime() + random( 10, 15 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE, true )

            grenade:SetModel( "models/weapons/w_eq_smokegrenade.mdl" )
            grenade:SetPos( srcPos )
            grenade:SetOwner( self )
            grenade:Spawn()

            grenade:PhysicsInit( SOLID_VPHYSICS )
            grenade:SetMoveCollide( MOVECOLLIDE_FLY_CUSTOM )
            grenade:AddSolidFlags( FSOLID_NOT_STANDABLE )

            grenade:SetGravity( 0.4 )
            grenade:SetFriction( 0.2 )
            grenade:SetElasticity( 0.45 )

            grenade.l_BlowTime = ( CurTime() + 1.5 )

            local phys = grenade:GetPhysicsObject()
            if IsValid( phys ) then
                phys:ApplyForceCenter( ( target:GetPos() - srcPos ):GetNormalized() * 750 + self.loco:GetVelocity() )

                angularVel.y = random( -1200, 1200 )
                phys:SetAngleVelocity( angularVel )
            end

            function grenade:PhysicsCollide( colData, collider )
                if colData.Speed >= 100 then grenade:EmitSound( "SmokeGrenade.Bounce" ) end
            end

            function grenade:Think()
                if CurTime() < grenade.l_BlowTime then return end
                if grenade:GetVelocity():Length() > 0.1 then
                    grenade.l_BlowTime = ( CurTime() + 0.2 )
                    return
                end

                local grenPos = grenade:GetPos()
                for i = 1, 5 do
                    local smokeEnt = ents_Create( "env_particlesmokegrenade" )
                    smokeEnt:SetPos( grenPos )
                    smokeEnt:SetSaveValue( "m_CurrentStage", 1 )
                    smokeEnt:Spawn()
                    smokeEnt:Activate()
                    SimpleTimer( 25, function() if IsValid( smokeEnt ) then smokeEnt:Remove() end end )
                end
                LambdaCSS_GrenadeSmokes[ grenade ] = { grenPos, ( CurTime() + 20 ) }

                grenade:EmitSound( "BaseSmokeEffect.Sound" )
                grenade:Remove()
            end

            return true
        end
	}
} )