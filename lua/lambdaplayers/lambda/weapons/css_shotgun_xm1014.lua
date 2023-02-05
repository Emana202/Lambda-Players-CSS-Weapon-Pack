local function OnShotgunReload( self )
    if self:GetWeaponName() == "css_shotgun_xm1014" and self.l_Clip > 0 then return end
    self:OldReloadWeapon()
end

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_shotgun_xm1014 = {
		model = "models/weapons/w_shot_xm1014.mdl",
		bonemerge = true,
		holdtype = "shotgun",
		prettyname = "Leone YG1265 Auto Shotgun",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_shotgun_xm1014",

        islethal = true,
        keepdistance = 350,
        attackrange = 800,
        speedmultiplier = 0.96,

		clip = 7,
        damage = 7,
        spread = 0.15,
        rateoffire = 0.4,
        bulletcount = 6,
        tracername = "Tracer",
        muzzleflash = 7,
        shelleject = "ShotgunShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "Weapon_XM1014.Single",

        reloadtime = 4.6,
        reloadsounds = { 
            { 0.7, "Weapon_XM1014.Insertshell" },
            { 1.2, "Weapon_XM1014.Insertshell" },
            { 1.7, "Weapon_XM1014.Insertshell" },
            { 2.2, "Weapon_XM1014.Insertshell" },
            { 2.7, "Weapon_XM1014.Insertshell" },
            { 3.2, "Weapon_XM1014.Insertshell" },
            { 3.7, "Weapon_XM1014.Insertshell" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_DEagle.Deploy" )

            self.OldReloadWeapon = self.ReloadWeapon
            self.ReloadWeapon = OnShotgunReload
        end,

        OnUnequip = function( self, wepent )
            self.ReloadWeapon = self.OldReloadWeapon
            self.OldReloadWeapon = nil
        end,

        OnReload = function( self, wepent )
            local animID = self:LookupSequence( "reload_shotgun_base_layer" )
            local reloadLayer = ( animID != -1 and self:AddGestureSequence( animID ) or self:AddGesture( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN ) )
            self:SetLayerPlaybackRate( reloadLayer, 0.5 )
        end
	}
} )