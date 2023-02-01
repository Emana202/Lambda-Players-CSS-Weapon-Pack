table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_aug = {
		model = "models/weapons/w_rif_aug.mdl",
		bonemerge = true,
		holdtype = "smg",
		prettyname = "Bullpup",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_aug",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,

		clip = 30,
        damage = 8,
        spread = 0.1,
        rateoffire = 0.09,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_AUG.Single",

        reloadtime = 3.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.5,
        reloadsounds = { 
            { 0.4, "Weapon_AUG.Boltpull" },
            { 1.4, "Weapon_AUG.Clipout" },
            { 2.6, "Weapon_AUG.Clipin" },
            { 3.3, "Weapon_AUG.Boltslap" }
        },

        OnEquip = function( self, wepent )
        	wepent:EmitSound( "Weapon_AUG.Forearm" )
        end
	}
} )