table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_sg552 = {
		model = "models/weapons/w_rif_sg552.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Krieg 552 Commando",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_sg552",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,

		clip = 30,
        damage = 8,
        spread = 0.1,
        rateoffire = 0.1,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_SG552.Single",

        reloadtime = 2.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.75,
        reloadsounds = { 
            { 0.4, "Weapon_SG552.Clipout" },
            { 1.4, "Weapon_SG552.Clipin" },
            { 2.1, "Weapon_SG552.Boltpull" }
        },

        OnEquip = function( self, wepent )
        	wepent:EmitSound( "Weapon_DEagle.Deploy" )
        end
	}
} )