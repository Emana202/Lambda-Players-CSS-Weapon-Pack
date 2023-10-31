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

if ( SERVER ) then
    local sqrt = math.sqrt
    local ipairs = ipairs
    local pairs = pairs
    local table_remove = table.remove
    local CurTime = CurTime
    local FindByClass = ents.FindByClass
    
    LambdaCSS_GrenadeSmokes = LambdaCSS_GrenadeSmokes or {}

    local function LambdaOnFlashBanged( lambda )
        if lambda.l_BlindedByFlashbang then return true end
    end

    local function CheckTotalSmokedLength( grenPos, srcPos, targetPos )
        local sightDir = ( targetPos - srcPos )
        local sightLength = sightDir:Length()
        sightDir:Normalize()

        local smokeOrigin = ( grenPos + vector_up * 60 )
        if srcPos:DistToSqr( smokeOrigin ) < 24025 or targetPos:DistToSqr( smokeOrigin ) < 24025 then return -1 end

        local toGrenade = ( smokeOrigin - srcPos )
        local alongDist = toGrenade:Dot( sightDir )

        local close = ( alongDist < 0 and srcPos or ( alongDist >= sightLength and targetPos or ( srcPos + sightDir * alongDist ) ) )
        local lengthSq = smokeOrigin:DistToSqr( close )
        
        return ( lengthSq >= 24025 and 0 or ( 2 * sqrt( 24025 - lengthSq ) ) )
    end

    local function OnLambdaCanSeeEntity( lambda, ent, tr )
        if lambda.l_BlindedByFlashbang then return true end

        if !lambda:IsInRange( tr.HitPos, 128 ) then
            local totalSmokedLength = 0
            for grenade, data in pairs( LambdaCSS_GrenadeSmokes ) do
                if !IsValid( grenade ) or CurTime() >= data[ 2 ] then
                    LambdaCSS_GrenadeSmokes[ grenade ] = nil
                    continue
                end

                local lengthAdd = CheckTotalSmokedLength( data[ 1 ], tr.StartPos, tr.HitPos )
                if lengthAdd == -1 then return true end

                totalSmokedLength = ( totalSmokedLength + lengthAdd )
                if totalSmokedLength > 108.50 then return true end
            end
        end
    end

    if LambdaIsForked then
        hook.Add( "LambdaOnCanSeeEntity", "LambdaCSS_LambdaOnCanSeeEntity", OnLambdaCanSeeEntity )
        hook.Add( "LambdaOnOtherKilled", "LambdaCSS_LambdaOnOtherKilled", LambdaOnFlashBanged )
    else
        local visibilitytrace = {}
        local Trace = util.TraceLine

        local function DetourCanSee( lambda, ent )
            if !IsValid( ent ) then return false end

            visibilitytrace.start = lambda:GetAttachmentPoint( "eyes" ).Pos
            visibilitytrace.endpos = ent:WorldSpaceCenter()
            visibilitytrace.filter = lambda

            local result = Trace( visibilitytrace )
            if OnLambdaCanSeeEntity( lambda, ent, result ) == true then return false end

            return ( result.Fraction == 1.0 or result.Entity == ent )
        end

        local function OnLambdaOnInitialize( lambda )
            lambda.CanSee = DetourCanSee
        end

        hook.Add( "LambdaOnInitialize", "LambdaCSS_LambdaOnInitialize", OnLambdaOnInitialize )
    end

    hook.Add( "LambdaOnAttackTarget", "LambdaCSS_LambdaOnAttackTarget", LambdaOnFlashBanged )
    hook.Add( "LambdaCanTarget", "LambdaCSS_LambdaOnCanTarget", LambdaOnFlashBanged )
end