table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_smg_mac10 = {
		model = "models/weapons/w_smg_mac10.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "Ingram MAC-10",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_smg_mac10",

        islethal = true,
		keepdistance = 400,
		attackrange = 1000,

		clip = 30,
        damage = 7,
        spread = 0.142,
        rateoffire = 0.07,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "Weapon_MAC10.Single",

        reloadtime = 3.1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.6, "Weapon_MAC10.Clipout" },
            { 1.6, "Weapon_MAC10.Clipin" },
            { 2.5, "Weapon_MAC10.Boltpull" }
        }
	}
} )