local callbackTbl = { cooldown = true }
local Rand = math.Rand

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_sniper_g3sg1 = {
		model = "models/weapons/w_snip_g3sg1.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "D3/AU-1 Semi-Auto Sniper Rifle",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_sniper_g3sg1",

        islethal = true,
		keepdistance = 1500,
		attackrange = 3000,
        speedmultiplier = 0.84,

		clip = 20,
        damage = 45,
        spread = 0.1,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_G3SG1.Single",

        reloadtime = 4.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.55,
        reloadsounds = { 
            { 0.6, "Weapon_G3SG1.Slide" },
            { 1.8, "Weapon_G3SG1.Clipin" },
            { 2.9, "Weapon_G3SG1.Clipout" },
            { 3.9, "Weapon_G3SG1.Slide" }
        },

        OnAttack = function( self, wepent )
            self.l_WeaponUseCooldown = CurTime() + Rand( 0.33, 0.5 )
            return callbackTbl
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 5 then return true end
        end
	}
} )