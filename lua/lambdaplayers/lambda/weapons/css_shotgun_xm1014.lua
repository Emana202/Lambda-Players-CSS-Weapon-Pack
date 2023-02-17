local random = math.random
local coroutine_wait = coroutine.wait

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_shotgun_xm1014 = {
		model = "models/weapons/w_shot_xm1014.mdl",
		bonemerge = true,
		holdtype = "shotgun",
		prettyname = "Leone YG1265 Auto Shotgun",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_shotgun_xm1014",

        islethal = true,
        keepdistance = 350,
        attackrange = 800,
        speedmultiplier = 0.96,

		clip = 7,
        damage = 7,
        spread = 0.15,
        rateoffire = 0.4,
        bulletcount = 6,
        tracername = "Tracer",
        muzzleflash = 7,
        shelleject = "ShotgunShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "Weapon_XM1014.Single",

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_DEagle.Deploy" )
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

                coroutine_wait( 0.7 )
                
                while ( self.l_Clip < self.l_MaxClip ) do
                    local ene = self:GetEnemy()
                    if self.l_Clip > 0 and random( 1, 2 ) == 1 and self:InCombat() and self:IsInRange( ene, 512 ) and self:CanSee( ene ) then break end
                    self.l_Clip = self.l_Clip + 1
                    wepent:EmitSound( "Weapon_XM1014.Insertshell" )
                    coroutine_wait( 0.5 )
                end

                coroutine_wait( 0.4 )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN )
                self:SetIsReloading( false )
            
            end, "CSS_ShotgunReload" )

            return true
        end
	}
} )