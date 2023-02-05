local random = math.random
local Rand = math.Rand
local bulletTbl = {
    Damage = 9,
    Force = 9,
    Spread = Vector( 0.075, 0.075, 0 ),
    HullSize = 5,
    TracerName = "Tracer",
}
local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_famas = {
		model = "models/weapons/w_rif_famas.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Clarion 5.56",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_famas",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,
        speedmultiplier = 0.88,

		clip = 25,
        damage = 9,
        spread = 0.1,
        rateoffire = 0.09,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_FAMAS.Single",

        reloadtime = 3.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.5, "Weapon_FAMAS.Clipout" },
            { 1.5, "Weapon_FAMAS.Clipin" },
            { 2.3, "Weapon_FAMAS.Forearm" }
        },

        OnEquip = function( self, wepent )
            wepent.IsBurstFireOn = ( random( 1, 4 ) == 1 )
        end,

        callback = function( self, wepent, target )
            if !wepent.IsBurstFireOn then return end
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + Rand( 0.5, 0.66 )

            self:NamedTimer( "Famas_BurstFire", 0.09, 3, function() 
                if self.l_Clip <= 0 then self:ReloadWeapon() return true end

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2, true )

                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "RifleShellEject", shelloffpos, shelloffang )

                bulletTbl.Src = wepent:GetPos()
                bulletTbl.Dir = ( IsValid( target ) and ( target:WorldSpaceCenter() - bulletTbl.Src ):GetNormalized() or wepent:GetForward() )
                bulletTbl.Attacker = self
                bulletTbl.IgnoreEntity = self
                
                wepent:FireBullets( bulletTbl )
                wepent:EmitSound( "Weapon_FAMAS.Single" )

                self.l_Clip = ( self.l_Clip - 1 )
            end )

            return true
        end
	}
} )