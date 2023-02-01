table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_sniper_sg550 = {
		model = "models/weapons/w_snip_sg550.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Krieg 550 Commando",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_sniper_sg550",

        islethal = true,
		keepdistance = 1500,
		attackrange = 3000,

		clip = 30,
        damage = 23,
        spread = 0.09,
        rateoffire = 0.35,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_SG550.Single",

        reloadtime = 3.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.55,
        reloadsounds = { 
            { 0.7, "Weapon_SG550.Clipout" },
            { 1.6, "Weapon_SG550.Clipin" },
            { 2.9, "Weapon_SG550.Boltpull" }
        }
	}
} )