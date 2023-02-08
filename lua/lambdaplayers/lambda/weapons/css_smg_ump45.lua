table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_smg_ump45 = {
		model = "models/weapons/w_smg_ump45.mdl",
		bonemerge = true,
		holdtype = "smg",
		prettyname = "K&M UMP45",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_smg_ump45",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 25,
        damage = 8,
        spread = 0.1,
        rateoffire = 0.105,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "Weapon_UMP45.Single",

        reloadtime = 3.4,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 0.6,
        reloadsounds = { 
            { 0.6, "Weapon_UMP45.Clipout" },
            { 1.7, "Weapon_UMP45.Clipin" },
            { 2.6, "Weapon_UMP45.Boltslap" }
        },

        OnReload = function( self, wepent )
            if self.l_Clip > 10 then return true end
        end
	}
} )