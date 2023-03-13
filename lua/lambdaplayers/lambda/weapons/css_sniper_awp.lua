local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )
local callbackTbl = { cooldown = true }
local Rand = math.Rand

local scopedCallbackTbl = { damage = true, cooldown = true }
local scopedBullet = {
    Damage = 90,
    Force = 90,
    Spread = Vector( 0.2, 0.2, 0 ),
    TracerName = "Tracer",
    HullSize = 5
}

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
        spread = 0.066,
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

        OnDeploy = function( self, wepent )
            wepent.IsScopedIn = false
        end,

        OnAttack = function( self, wepent, target )
            local scopedIn = wepent.IsScopedIn
            self.l_WeaponUseCooldown = CurTime() + ( scopedIn and Rand( 3.0, 4.0 ) or Rand( 1.66, 2.0 ) )

            self:SimpleTimer( 0.6, function() 
                wepent:EmitSound( "Weapon_AWP.Bolt" )
                self:HandleShellEject( "RifleShellEject", shelloffpos, shelloffang ) 
            end )
            self:SimpleTimer( 1.0, function() 
                wepent:EmitSound( "Weapon_AWP.Bolt" )
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

            wepent.IsScopedIn = ( !isdead and LambdaIsValid( ene ) and self:GetState() == "Combat" and !self:IsInRange( ene, 512 ) and self:CanSee( ene ) )
            if wepent.IsScopedIn != curScoped then
                wepent:EmitSound( "Default.Zoom" )
            end

            self.l_HoldType = ( wepent.IsScopedIn and "rpg" or "ar2" )
            self.l_WeaponSpeedMultiplier = ( wepent.IsScopedIn and 0.55 or 0.84 )

            return Rand( 0.25, 0.5 )
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 3 then return true end
        end
	}
} )