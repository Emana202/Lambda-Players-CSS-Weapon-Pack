local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )
local callbackTbl = { cooldown = true }
local Rand = math.Rand

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_sniper_awp = {
		model = "models/weapons/w_snip_awp.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Magnum Sniper Rifle",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_sniper_awp",

        islethal = true,
		keepdistance = 1500,
		attackrange = 3000,
        speedmultiplier = 0.84,

		clip = 10,
        damage = 90,
        spread = 0.08,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = false,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_AWP.Single",

        reloadtime = 3.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.6,
        reloadsounds = { 
            { 0.9, "Weapon_AWP.Clipout" },
            { 1.7, "Weapon_AWP.Clipin" },
            { 3.0, "Weapon_AWP.Bolt" },
            { 3.4, "Weapon_AWP.Bolt" }
        },

        callback = function( self, wepent )
            self.l_WeaponUseCooldown = CurTime() + Rand( 2.25, 3.5 )

            self:SimpleTimer( 0.6, function() 
                wepent:EmitSound( "Weapon_AWP.Bolt" )
                self:HandleShellEject( "RifleShellEject", shelloffpos, shelloffang ) 
            end )
            self:SimpleTimer( 1.0, function() 
                wepent:EmitSound( "Weapon_AWP.Bolt" )
            end )

            return callbackTbl
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 2 then return true end
        end
	}
} )