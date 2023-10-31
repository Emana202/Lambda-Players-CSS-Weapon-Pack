local callbackTbl = { cooldown = true }
local Rand = math.Rand

local scopedCallbackTbl = { damage = true, cooldown = true }
local scopedBullet = {
    Damage = 45,
    Force = 45,
    Spread = Vector( 0.3, 0.3, 0 ),
    TracerName = "Tracer",
    HullSize = 5
}

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
        spread = 0.066,
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