local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )
local callbackTbl = { cooldown = true }
local Rand = math.Rand

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_sniper_scout = {
		model = "models/weapons/w_snip_scout.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Schmidt Scout",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_sniper_scout",

        islethal = true,
		keepdistance = 1500,
		attackrange = 3000,
        speedmultiplier = 1.04,

		clip = 10,
        damage = 65,
        spread = 0.075,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = false,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_Scout.Single",

        reloadtime = 3.0,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.6, "Weapon_Scout.Clipout" },
            { 1.4, "Weapon_Scout.Clipin" },
            { 2.1, "Weapon_Scout.Bolt" }
        },

        callback = function( self, wepent )
            self.l_WeaponUseCooldown = CurTime() + Rand( 1.5, 2.5 )

            self:SimpleTimer( 0.5, function() 
                wepent:EmitSound( "Weapon_Scout.Bolt" )
                self:HandleShellEject( "RifleShellEject", shelloffpos, shelloffang ) 
            end )

            return callbackTbl
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 2 then return true end
        end
	}
} )