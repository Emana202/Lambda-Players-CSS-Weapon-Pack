table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_galil = {
		model = "models/weapons/w_rif_galil.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "IDF Defender",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_galil",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,

		clip = 35,
        damage = 8,
        spread = 0.125,
        rateoffire = 0.09,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_Galil.Single",

        reloadtime = 2.9,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.4, "Weapon_Galil.Clipout" },
            { 1.4, "Weapon_Galil.Clipin" },
            { 2.1, "Weapon_Galil.Boltpull" }
        }
	}
} )