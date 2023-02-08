table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_smg_mp5 = {
		model = "models/weapons/w_smg_mp5.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "K&M Sub-Machine Gun",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_smg_mp5",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 30,
        damage = 6,
        spread = 0.12,
        rateoffire = 0.075,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "Weapon_MP5Navy.Single",

        reloadtime = 3.1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.5, "Weapon_MP5Navy.Clipout" },
            { 1.5, "Weapon_MP5Navy.Clipin" },
            { 2.3, "Weapon_MP5Navy.Slideback" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_MP5Navy.Slideback" )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 15 then return true end
        end
	}
} )