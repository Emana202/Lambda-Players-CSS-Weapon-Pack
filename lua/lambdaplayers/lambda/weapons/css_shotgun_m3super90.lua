local random = math.random
local coroutine_wait = coroutine.wait

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_shotgun_m3super90 = {
		model = "models/weapons/w_shot_m3super90.mdl",
		bonemerge = true,
		holdtype = "shotgun",
		prettyname = "Leone 12 Gauge Super",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_shotgun_m3super90",

        islethal = true,
		keepdistance = 350,
		attackrange = 800,
        speedmultiplier = 0.88,

		clip = 8,
        damage = 8,
        spread = 0.15,
        rateoffire = 0.9,
        bulletcount = 8,
        tracername = "Tracer",
        muzzleflash = 7,
        shelleject = false,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "Weapon_M3.Single",

        OnAttack = function( self, wepent )
            self:SimpleTimer( 0.5, function() self:HandleShellEject( "ShotgunShellEject", shelloffpos, shelloffang ) end )
        end,

        OnDeploy = function( self, wepent )
            wepent:EmitSound( "Weapon_M3.Pump" )
        end,

        OnReload = function( self, wepent )
            local animID = self:LookupSequence( "reload_shotgun_base_layer" )
            if animID != -1 then 
                self:AddGestureSequence( animID ) 
            else 
                self:AddGesture( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN )
            end

            self:SetIsReloading( true )
            self:Thread( function()

                coroutine_wait( 0.4 )
                
                while ( self.l_Clip < self.l_MaxClip ) do
                    local ene = self:GetEnemy()
                    if self.l_Clip > 0 and random( 1, 2 ) == 1 and self:InCombat() and self:IsInRange( ene, 512 ) and self:CanSee( ene ) then break end
                    self.l_Clip = self.l_Clip + 1
                    wepent:EmitSound( "Weapon_M3.Insertshell" )
                    coroutine_wait( 0.5 )
                end

                self:SimpleTimer( 0.3, function() wepent:EmitSound( "Weapon_M3.Pump" ) end )
                coroutine_wait( 0.8 )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN )
                self:SetIsReloading( false )
            
            end, "CSS_ShotgunReload" )

            return true
        end
	}
} )