table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_smg_tmp = {
		model = "models/weapons/w_smg_tmp.mdl",
		bonemerge = true,
		holdtype = "smg",
		prettyname = "Schmidt Machine Pistol",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_smg_tmp",

        islethal = true,
		keepdistance = 400,
		attackrange = 1000,

		clip = 30,
        damage = 6,
        spread = 0.14,
        rateoffire = 0.07,
        tracername = "Tracer",
        muzzleflash = false,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "Weapon_TMP.Single",

        reloadtime = 2.1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 1,
        reloadsounds = { 
            { 0.5, "Weapon_TMP.Clipout" },
            { 1.3, "Weapon_TMP.Clipin" }
        },

        OnReload = function( self, wepent )
            if self.l_Clip > 15 then return true end
        end
	}
} )