local random = math.random
local Rand = math.Rand
local bulletTbl = {
    Damage = 11,
    Force = 11,
    HullSize = 5,
    Spread = Vector( 0.075, 0.075, 0 ),
    TracerName = "Tracer"
}
local shelloffpos = Vector( 10, 0, 3 )
local shelloffang = Angle( 0, -90, 0 )

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_glock = {
		model = "models/weapons/w_pist_glock18.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "9x19mm Sidearm",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_glock",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 20,
        damage = 9,
        spread = 0.09,
        rateoffire = 0.17,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "Weapon_Glock.Single",

        reloadtime = 2.1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.8,
        reloadsounds = { 
            { 0, "Weapon_Glock.Slideback" },
            { 0.4, "Weapon_Glock.Clipout" },
            { 1.1, "Weapon_Glock.Clipin" },
            { 1.8, "Weapon_Glock.Sliderelease" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_Glock.Sliderelease" )
            wepent.IsBurstFireOn = ( random( 1, 4 ) == 1 )
        end,

        callback = function( self, wepent, target )
            if !wepent.IsBurstFireOn then return end
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + Rand( 0.5, 0.66 )

            self:NamedTimer( "Glock_BurstFire", 0.05, 3, function() 
                if self.l_Clip <= 0 then self:ReloadWeapon() return true end

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL, true )

                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "ShellEject", shelloffpos, shelloffang )

                bulletTbl.Src = wepent:GetPos()
                bulletTbl.Dir = ( IsValid( target ) and ( target:WorldSpaceCenter() - bulletTbl.Src ):GetNormalized() or wepent:GetForward() )
                bulletTbl.Attacker = self
                bulletTbl.IgnoreEntity = self
                
                wepent:FireBullets( bulletTbl )
                wepent:EmitSound( "Weapon_Glock.Single" )

                self.l_Clip = ( self.l_Clip - 1 )
            end )

            return true
        end,

        OnReload = function( self, wepent )
            if self.l_Clip > 10 then return true end
        end
	}
} )