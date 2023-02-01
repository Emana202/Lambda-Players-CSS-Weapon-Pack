local random = math.random
local silencedCallbackTbl = { damage = true, muzzleflash = true, sound = true }
local silencedbulletTbl = {
    Damage = 12,
    Force = 12,
    Spread = Vector( 0.075, 0.075, 0 ),
    HullSize = 5,
    TracerName = "Tracer",
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_pistol_usp = {
		model = "models/weapons/w_pist_usp.mdl",
		bonemerge = true,
		holdtype = "pistol",
		prettyname = "K&M .45 Tactical",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_pistol_usp",

        islethal = true,
		keepdistance = 500,
		attackrange = 1500,

		clip = 12,
        damage = 13,
        spread = 0.1,
        rateoffire = 0.2,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "Weapon_USP.Single",

        reloadtime = 2.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.6,
        reloadsounds = { 
            { 0, "Weapon_USP.Slideback2" },
            { 0.5, "Weapon_USP.Clipout" },
            { 1.1, "Weapon_USP.Clipin" },
            { 2.3, "Weapon_USP.Sliderelease" }
        },

        OnEquip = function( self, wepent )
            wepent:EmitSound( "Weapon_USP.Slideback" )

            wepent.IsSilencerOn = ( random( 1, 3 ) == 1 )
            if wepent.IsSilencerOn then wepent:SetModel( "models/weapons/w_pist_usp_silencer.mdl" ) end
        end,

        callback = function( self, wepent, target )
            if !wepent.IsSilencerOn then return end
            
            wepent:EmitSound( "Weapon_USP.SilencedShot" )

            silencedbulletTbl.Attacker = self
            silencedbulletTbl.IgnoreEntity = self
            silencedbulletTbl.Src = wepent:GetPos()
            silencedbulletTbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            wepent:FireBullets( silencedbulletTbl )
            
            return silencedCallbackTbl
        end
	}
} )