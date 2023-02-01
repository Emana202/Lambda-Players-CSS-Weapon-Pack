table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_fiveseven = {
		model = "models/weapons/w_pist_fiveseven.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "ES Five-Seven",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_fiveseven",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 20,
        damage = 14,
        spread = 0.125,
        rateoffire = 0.18,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "Weapon_FiveSeven.Single",

        reloadtime = 3.2,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.5,
        reloadsounds = { 
            { 0, "Weapon_FiveSeven.Slideback" },
            { 0.6, "Weapon_FiveSeven.Clipout" },
            { 1.4, "Weapon_FiveSeven.Clipin" },
            { 2.6, "Weapon_FiveSeven.Sliderelease" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_FiveSeven.Slidepull" )
        end
	}
} )