local random = math.random
local silencedCallbackTbl = { damage = true, muzzleflash = true, sound = true }
local silencedbulletTbl = {
	Damage = 6,
	Force = 6,
	Spread = Vector( 0.09, 0.09, 0 ),
    HullSize = 5,
    TracerName = "Tracer",
}

table.Merge( _LAMBDAPLAYERSWEAPONS, {
	css_rifle_m4a1 = {
		model = "models/weapons/w_rif_m4a1.mdl",
		bonemerge = true,
		holdtype = "ar2",
		prettyname = "Maverick M4A1 Carbine",
		origin = "Counter-Strike: Source",
        killicon = "lambdakillicons_css_rifle_m4a1",

        islethal = true,
		keepdistance = 500,
		attackrange = 2000,

		clip = 30,
        damage = 7,
        spread = 0.11,
        rateoffire = 0.09,
        tracername = "Tracer",
        muzzleflash = 1,
        shelleject = "RifleShellEject",
        shelloffpos = Vector( 10, 0, 3 ),
        shelloffang = Angle( 0, -90, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2,
        attacksnd = "Weapon_M4A1.Single",

        reloadtime = 3.0,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.66,
        reloadsounds = { 
            { 0.6, "Weapon_M4A1.Clipout" },
            { 1.4, "Weapon_M4A1.Clipin" },
            { 2.3, "Weapon_M4A1.Boltpull" }
        },

        OnEquip = function( self, wepent )
        	wepent:EmitSound( "Weapon_M4A1.Deploy" )
	        self:SimpleTimer( 0.4, function() wepent:EmitSound( "Weapon_M4A1.Boltpull" ) end )

        	wepent.IsSilencerOn = ( random( 1, 3 ) == 1 )
        	if wepent.IsSilencerOn then wepent:SetModel( "models/weapons/w_rif_m4a1_silencer.mdl" ) end
        end,

        callback = function( self, wepent, target )
        	if !wepent.IsSilencerOn then return end
        	
        	wepent:EmitSound( "Weapon_M4A1.Silenced" )

        	silencedbulletTbl.Attacker = self
        	silencedbulletTbl.IgnoreEntity = self
        	silencedbulletTbl.Src = wepent:GetPos()
        	silencedbulletTbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
        	wepent:FireBullets( silencedbulletTbl )
        	
        	return silencedCallbackTbl
        end
	}
} )