local CurTime = CurTime
local Rand = math.Rand
local callbackTbl = { damage = true, cooldown = true }
local scopedBullet = {
    Damage = 8,
    Force = 8,
    Spread = Vector( 0.08, 0.08, 0 ),
    TracerName = "Tracer",
    HullSize = 5
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_aug = {
		model = "models/weapons/w_rif_aug.mdl",
		bonemerge = true,
		holdtype = "smg",
		prettyname = "Bullpup",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_aug",

        islethal = true,
		keepdistance = 600,
		attackrange = 2000,
        speedmultiplier = 0.884,

		clip = 30,
        damage = 8,
        spread = 0.14,
        rateoffire = 0.09,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_AUG.Single",

        reloadtime = 3.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.5,
        reloadsounds = { 
            { 0.4, "Weapon_AUG.Boltpull" },
            { 1.4, "Weapon_AUG.Clipout" },
            { 2.6, "Weapon_AUG.Clipin" },
            { 3.3, "Weapon_AUG.Boltslap" }
        },

        OnEquip = function( self, wepent )
        	wepent.IsScopedIn = false
            wepent:EmitSound( "Weapon_AUG.Forearm" )
        end,

        callback = function( self, wepent, target )
            if !wepent.IsScopedIn then return end

            self.l_WeaponUseCooldown = CurTime() + 0.135

            scopedBullet.Attacker = self
            scopedBullet.IgnoreEntity = self
            scopedBullet.Src = wepent:GetPos()
            scopedBullet.Dir = ( target:WorldSpaceCenter() - scopedBullet.Src ):GetNormalized()
            wepent:FireBullets( scopedBullet )

            return callbackTbl
        end,

        OnThink = function( self, wepent )
            local ene = self:GetEnemy()
            wepent.IsScopedIn = ( LambdaIsValid( ene ) and self:GetState() == "Combat" and !self:IsInRange( ene, 768 ) and self:CanSee( ene ) )
            
            self.l_HoldType = ( wepent.IsScopedIn and "rpg" or "ar2" )
            self.l_WeaponSpeedMultiplier = ( wepent.IsScopedIn and 0.66 or 0.884 )

            return Rand( 0.25, 0.5 )
        end
	}
} )