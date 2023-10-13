table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_machinegun_m249 = {
		model = "models/weapons/w_mach_m249para.mdl",
		bonemerge = true,
		holdtype = "shotgun",
		prettyname = "ES M249 Para",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_machinegun_m249",

        islethal = true,
		keepdistance = 400,
		attackrange = 1000,
        speedmultiplier = 0.88,

		clip = 100,
        damage = 7,
        spread = 0.133,
        rateoffire = 0.075,
        bulletcount = 1,
        tracername = "Tracer",
        muzzleflash = 7,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_M249.Single",

        reloadtime = 5.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.4,
        reloadsounds = { 
            { 0.5, "Weapon_M249.Boxout" },
            { 1.5, "Weapon_M249.Coverup" },
            { 2.7, "Weapon_M249.Boxin" },
            { 3.3, "Weapon_M249.Chain" },
            { 4.5, "Weapon_M249.Coverdown" }
        },

        OnReload = function( self, wepent )
            if self.l_Clip > 0 then return true end
        end
	}
} )