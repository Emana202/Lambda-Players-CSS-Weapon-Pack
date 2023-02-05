table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_ak47 = {
		model = "models/weapons/w_rif_ak47.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "CV-47",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_ak47",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,
        speedmultiplier = 0.884,

		clip = 30,
        damage = 9,
        spread = 0.125,
        rateoffire = 0.1,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_AK47.Single",

        reloadtime = 2.4,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.9,
        reloadsounds = { 
            { 0.4, "Weapon_AK47.Clipout" },
            { 1.5, "Weapon_AK47.Clipin" }
        },

        OnEquip = function( self, wepent )
        	wepent:EmitSound( "Weapon_AK47.BoltPull" )
        end
	}
} )