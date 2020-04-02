include("suits.jl")
include("rtgeom.jl")
include("refltrans.jl")
include("hotspot.jl")
include("volscatt.jl")
include("lidf.jl")

function foursail(leaf_refl, leaf_trans, soil_refl, LAI,
                  hot_spot = 0.01,
                  solar_zenith = 0,
                  instrument_zenith = 0,
                  azimuth = 0)
    d2r = π/180

    # Simple geometric quantities
    cts = cos(d2r * solar_zenith)
    cto = cos(d2r * instrument_zenith)
    ctscto = cts * cto

    tants = tan(d2r * solar_zenith)
    tanto = tan(d2r * instrument_zenith)
    cospsi = cos(d2r * azimuth)

    dso = sqrt(tants^2 + tanto^2 - 2 * tants * tanto * cospsi)

    # Leaf angle distribution
    # TODO: Currently spherical. Make more flexible.
    # TODO: Arbitrary leaf angles (not 13)
    litab = Array{Real}(vcat([5:10:75;], [81:2:89;]))
    dcum_in = vcat([10:10:80;], [82:2:88;])
    F_lidf = vcat(dcum.(-0.35, -0.15, dcum_in), 1)
    lidf = F_lidf
    for i in 13:-1:2
        lidf[i] = lidf[i] - lidf[i-1]
    end

    # Angular distance
    ks, ko, sob, sof, sdb, sdf, dob, dof, ddb, ddf =
        suits(litab, lidf, solar_zenith, instrument_zenith,
              cts, cto, azimuth, ctscto)

    # Geometric leaf reflectance
    sigb, att, m, sb, sf, vb, vf, w =
        rtgeom(leaf_refl, leaf_trans,
               ddb, ddf, sdb, sdf,
               dob, dof, sob, sof)

    # Canopy reflectance and transmittance
    rdd, tdd, tsd, rsd, tdo, rdo, tss, too, rsod =
        refltrans(LAI, ks, ko,
                  leaf_refl, leaf_trans,
                  att, m, sigb, sf, sb, vf, vb)

    # Hotspot effect
    tsstoo, sumint = hotspot(LAI, hot_spot, tss, ks, ko, dso)

    # Final BRDF calculations
    rsos  = w * LAI * sumint        # Single scattering contribution
    rso   = rsos + rsod           # Total canopy contribution
    dn    = 1 - soil_refl * rdd        #Interaction with the soil

    # rddt: bi-hemispherical reflectance factor
    rddt  = rdd + tdd * soil_refl * tdd/dn

    # rsdt: directional-hemispherical reflectance factor for solar incident flux
    rsdt  = rsd + (tsd+tss) * soil_refl * tdd/dn

    # rdot: hemispherical-directional reflectance factor in viewing direction
    rdot  = rdo+tdd*soil_refl*(tdo+too)/dn

    # rsot: bi-directional reflectance factor
    rsodt = rsod+((tss+tsd)*tdo+(tsd+tss*soil_refl*rdd)*too)*soil_refl/dn
    rsost = rsos+tsstoo*soil_refl
    rsot  = rsost+rsodt

    [rddt rsdt rdot rsot]
end
