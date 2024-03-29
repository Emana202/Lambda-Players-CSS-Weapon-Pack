local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )
local callbackTbl = { cooldown = true }
local Rand = math.Rand

local scopedCallbackTbl = { damage = true, cooldown = true }
local scopedBullet = {
    Damage = 65,
    Force = 65,
    Spread = Vector( 0.15, 0.15, 0 ),
    TracerName = "Tracer",
    HullSize = 5
}

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
        spread = 0.05,
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

        OnDeploy = function( self, wepent )
            wepent.IsScopedIn = false
        end,

        OnAttack = function( self, wepent, target )
            local scopedIn = wepent.IsScopedIn
            self.l_WeaponUseCooldown = CurTime() + ( scopedIn and Rand( 2.5, 3.5 ) or Rand( 1.25, 1.66 ) )

            self:SimpleTimer( 0.5, function() 
                wepent:EmitSound( "Weapon_Scout.Bolt" )
                self:HandleShellEject( "RifleShellEject", shelloffpos, shelloffang ) 
            end )

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
            self.l_WeaponSpeedMultiplier = ( wepent.IsScopedIn and 0.66 or 1.04 )

            return Rand( 0.1, 0.33 )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 3 then return true end
        end
	}
} )