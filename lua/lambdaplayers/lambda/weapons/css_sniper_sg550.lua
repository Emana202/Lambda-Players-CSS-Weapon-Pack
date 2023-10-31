local callbackTbl = { cooldown = true }
local Rand = math.Rand

local scopedCallbackTbl = { damage = true, cooldown = true }
local scopedBullet = {
    Damage = 40,
    Force = 40,
    Spread = Vector( 0.25, 0.25, 0 ),
    TracerName = "Tracer",
    HullSize = 5
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_sniper_sg550 = {
		model = "models/weapons/w_snip_sg550.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Krieg 550 Commando",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_sniper_sg550",

        islethal = true,
		keepdistance = 1500,
		attackrange = 3000,
        speedmultiplier = 0.84,

		clip = 30,
        damage = 40,
        spread = 0.066,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_SG550.Single",

        reloadtime = 3.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.55,
        reloadsounds = { 
            { 0.7, "Weapon_SG550.Clipout" },
            { 1.6, "Weapon_SG550.Clipin" },
            { 2.9, "Weapon_SG550.Boltpull" }
        },

        OnAttack = function( self, wepent, target )
            local scopedIn = wepent.IsScopedIn
            self.l_WeaponUseCooldown = CurTime() + ( scopedIn and Rand( 0.75, 1.2 ) or Rand( 0.4, 0.6 ) )

            if !scopedIn then
                scopedBullet.Attacker = self
                scopedBullet.IgnoreEntity = self
                scopedBullet.Src = wepent:GetPos()
                scopedBullet.Dir = ( target:WorldSpaceCenter() - scopedBullet.Src ):GetNormalized()
                wepent:FireBullets( scopedBullet )
            end

            return ( scopedIn and callbackTbl or scopedCallbackTbl )
        end,

        OnThink = function( self, wepent, isdead )
            local ene = self:GetEnemy()
            local curScoped = wepent.IsScopedIn

            wepent.IsScopedIn = ( !isdead and LambdaIsValid( ene ) and self:GetState() == "Combat" and !self:IsInRange( ene, 400 ) and self:CanSee( ene ) )
            if wepent.IsScopedIn != curScoped then
                wepent:EmitSound( "Default.Zoom" )
            end

            self.l_HoldType = ( wepent.IsScopedIn and "sniperrifle" or "ar2" )
            self.l_WeaponSpeedMultiplier = ( wepent.IsScopedIn and 0.55 or 0.84 )

            return Rand( 0.1, 0.33 )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 5 then return true end
        end
	}
} )