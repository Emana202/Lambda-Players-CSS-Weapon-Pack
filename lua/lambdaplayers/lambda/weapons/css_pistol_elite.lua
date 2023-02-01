local EffectData = EffectData
local util_Effect = util.Effect
local callbackTbl = { shell = true, muzzleflash = true, anim = true }

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_elite = {
		model = "models/weapons/w_pist_elite.mdl",
		bonemerge = true,
		holdtype = "duel",
		prettyname = ".40 Dual Elites",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_elites",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 30,
        damage = 15,
        spread = 0.15,
        rateoffire = 0.18,
        tracername = "Tracer",
        attacksnd = "Weapon_ELITE.Single",

        reloadtime = 3.8,
        reloadsounds = { 
            { 0, "Weapon_ELITE.Reloadstart" },
            { 0.5, "Weapon_ELITE.Clipout" },
            { 1.5, "Weapon_ELITE.Rclipin" },
            { 2.4, "Weapon_ELITE.Lclipin" },
            { 3.3, "Weapon_ELITE.Sliderelease" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_ELITE.Deploy" )
        end,

        OnReload = function( self, wepent )
            local animID = self:LookupSequence( "reload_dual_base_layer" )
            local reloadLayer = ( animID != -1 and self:AddGestureSequence( animID ) or self:AddGesture( ACT_HL2MP_GESTURE_RELOAD_DUEL ) )
        end,

        callback = function( self, wepent, target )
            local muzzleName = "muzzle"
            local shellName = "shell"
            local fireAnim = "range_dual_l"
            if ( self.l_Clip % 2 ) == 1 then
                muzzleName = muzzleName .. 2
                shellName = shellName .. 2
                fireAnim = "range_dual_r"
            end

            local attachData = wepent:GetAttachment( wepent:LookupAttachment( muzzleName ) )
            local effectData = EffectData()
            effectData:SetOrigin( attachData.Pos )
            effectData:SetAngles( attachData.Ang )
            effectData:SetScale( 0.66 )
            util_Effect( "MuzzleEffect", effectData, true, true )

            attachData = wepent:GetAttachment( wepent:LookupAttachment( shellName ) )
            effectData = EffectData()
            effectData:SetEntity( wepent )
            effectData:SetOrigin( attachData.Pos )
            effectData:SetAngles( attachData.Ang )
            util_Effect( "ShellEject", effectData, true, true )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL )
            fireAnim = self:LookupSequence( fireAnim )
            if fireAnim != -1 then
                self:AddGestureSequence( fireAnim )
            else
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_DUEL )
            end

            return callbackTbl
        end
	}
} )