table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_deagle = {
		model = "models/weapons/w_pist_deagle.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "Night Hawk .50C",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_deagle",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 7,
        damage = 28,
        spread = 0.11,
        rateoffire = 0.4,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER,
        attacksnd = "Weapon_DEagle.Single",

        reloadtime = 2.1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.8,
        reloadsounds = { 
            { 0, "Weapon_DEagle.Slideback" },
            { 0.4, "Weapon_DEagle.Clipout" },
            { 1.0, "Weapon_DEagle.Clipin" }
        },

        OnDeploy = function( self, wepent )
            wepent:EmitSound( "Weapon_DEagle.Deploy" )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 4 then return true end
        end
	}
} )