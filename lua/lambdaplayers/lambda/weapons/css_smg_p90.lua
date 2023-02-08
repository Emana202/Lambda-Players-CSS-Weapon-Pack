table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_smg_p90 = {
		model = "models/weapons/w_smg_p90.mdl",
		bonemerge = true,
		holdtype = "smg",
		prettyname = "ES C90",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_smg_p90",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,
        speedmultiplier = 0.98,

		clip = 50,
        damage = 5,
        spread = 0.133,
        rateoffire = 0.07,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "Weapon_P90.Single",

        reloadtime = 3.4,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.6,
        reloadsounds = { 
            { 0.5, "Weapon_P90.Cliprelease" },
            { 0.9, "Weapon_P90.Clipout" },
            { 1.9, "Weapon_P90.Clipin" },
            { 2.6, "Weapon_P90.Boltpull" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_P90.Boltpull" )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 20 then return true end
        end
	}
} )