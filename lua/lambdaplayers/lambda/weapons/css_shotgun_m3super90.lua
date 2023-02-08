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

        reloadtime = 5.3,
        reloadsounds = { 
            { 0.4, "Weapon_M3.Insertshell" },
            { 0.9, "Weapon_M3.Insertshell" },
            { 1.4, "Weapon_M3.Insertshell" },
            { 1.9, "Weapon_M3.Insertshell" },
            { 2.4, "Weapon_M3.Insertshell" },
            { 2.9, "Weapon_M3.Insertshell" },
            { 3.4, "Weapon_M3.Insertshell" },
            { 3.9, "Weapon_M3.Insertshell" },
            { 4.7, "Weapon_M3.Pump" }
        },

        callback = function( self, wepent )
            self:SimpleTimer( 0.5, function() self:HandleShellEject( "ShotgunShellEject", shelloffpos, shelloffang ) end )
        end,

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_M3.Pump" )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 0 then return true end
            local animID = self:LookupSequence( "reload_shotgun_base_layer" )
            local reloadLayer = ( animID != -1 and self:AddGestureSequence( animID ) or self:AddGesture( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN ) )
            self:SetLayerPlaybackRate( reloadLayer, 0.5 )
        end
	}
} )