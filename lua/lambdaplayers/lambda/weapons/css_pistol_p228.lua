table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_p228 = {
		model = "models/weapons/w_pist_p228.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "228 Compact",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_p228",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 13,
        damage = 15,
        spread = 0.12,
        rateoffire = 0.19,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "Weapon_P228.Single",

        reloadtime = 2.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.6,
        reloadsounds = { 
            { 0, "Weapon_P228.Slideback" },
            { 0.7, "Weapon_P228.Clipout" },
            { 1.4, "Weapon_P228.Clipin" },
            { 2.3, "Weapon_P228.Sliderelease" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_P228.Slidepull" )
        end
	}
} )