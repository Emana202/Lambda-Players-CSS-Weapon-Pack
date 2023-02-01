if ( CLIENT ) then
    local iconColor = Color( 255, 80, 0, 255 )
    local cssFontName = "lambdakillicons_CSS_WeaponKillIcons"

    surface.CreateFont( cssFontName, { font = "csd", size = ScreenScale( 30 ), weight = 500, antialias = true, additive = true } )

    killicon.AddFont( "lambdakillicons_css_pistol_usp",           cssFontName,  "y",    iconColor )
    killicon.AddFont( "lambdakillicons_css_pistol_glock",         cssFontName,  "c",    iconColor )
    killicon.AddFont( "lambdakillicons_css_pistol_p228",          cssFontName,  "a",    iconColor )
    killicon.AddFont( "lambdakillicons_css_pistol_deagle",        cssFontName,  "f",    iconColor )
    killicon.AddFont( "lambdakillicons_css_pistol_fiveseven",     cssFontName,  "u",    iconColor )
    killicon.AddFont( "lambdakillicons_css_pistol_elites",        cssFontName,  "s",    iconColor )

    killicon.AddFont( "lambdakillicons_css_smg_tmp",              cssFontName,  "d",    iconColor )
    killicon.AddFont( "lambdakillicons_css_smg_mac10",            cssFontName,  "l",    iconColor )
    killicon.AddFont( "lambdakillicons_css_smg_mp5",              cssFontName,  "x",    iconColor )
    killicon.AddFont( "lambdakillicons_css_smg_ump45",            cssFontName,  "q",    iconColor )
    killicon.AddFont( "lambdakillicons_css_smg_p90",              cssFontName,  "m",    iconColor )

    killicon.AddFont( "lambdakillicons_css_rifle_famas",          cssFontName,  "t",    iconColor )
    killicon.AddFont( "lambdakillicons_css_rifle_galil",          cssFontName,  "v",    iconColor )
    killicon.AddFont( "lambdakillicons_css_rifle_m4a1",           cssFontName,  "w",    iconColor )
    killicon.AddFont( "lambdakillicons_css_rifle_ak47",           cssFontName,  "b",    iconColor )
    killicon.AddFont( "lambdakillicons_css_rifle_aug",            cssFontName,  "e",    iconColor )
    killicon.AddFont( "lambdakillicons_css_rifle_sg552",          cssFontName,  "A",    iconColor )

    killicon.AddFont( "lambdakillicons_css_shotgun_m3super90",    cssFontName,  "k",    iconColor )
    killicon.AddFont( "lambdakillicons_css_shotgun_xm1014",       cssFontName,  "B",    iconColor )

    killicon.AddFont( "lambdakillicons_css_sniper_scout",         cssFontName,  "n",    iconColor )
    killicon.AddFont( "lambdakillicons_css_sniper_awp",           cssFontName,  "r",    iconColor )
    killicon.AddFont( "lambdakillicons_css_sniper_sg550",         cssFontName,  "o",    iconColor )
    killicon.AddFont( "lambdakillicons_css_sniper_g3sg1",         cssFontName,  "i",    iconColor )

    killicon.AddFont( "lambdakillicons_css_knife",                cssFontName,  "j",    iconColor )
    killicon.AddFont( "lambdakillicons_css_machinegun_m249",      cssFontName,  "z",    iconColor )
    killicon.AddFont( "lambdakillicons_css_grenade_fraggrenade",  cssFontName,  "h",    iconColor )
    killicon.AddFont( "lambdakillicons_css_grenade_flashbang",    cssFontName,  "p",    iconColor )
end

local knifeTbl = _LAMBDAPLAYERSWEAPONS[ "knife" ]
if istable( knifeTbl ) then knifeTbl.killicon = "lambdakillicons_css_knife" end