function foursail_lrt(lrt, soil_refl, LAI, args...)
    nwl = size(lrt, 1)
    result = Array{Float64, 2}(undef, nwl, 4)
    for i in 1:nwl
        result[i,:] = foursail(lrt[i,1], lrt[i,2], LAI, soil_refl[i], args...)
    end
    result
end

function prospect4_4sail(N, Cab, Cw, Cm, LAI, soil_refl, args...)
    lrt = prospect4(N, Cab, Cw, Cm)
    foursail_lrt(lrt, soil_refl, LAI, args...)
end

function prospect5_4sail(N, Cab, Car, Cw, Cm, LAI, soil_refl, args...)
    lrt = prospect5(N, Cab, Car, Cw, Cm)
    foursail_lrt(lrt, soil_refl, LAI, args...)
end

function prospect5b_4sail(N, Cab, Car, Cbrown, Cw, Cm, LAI, soil_refl, args...)
    lrt = prospect5b(N, Cab, Car, Cbrown, Cw, Cm)
    foursail_lrt(lrt, soil_refl, LAI, args...)
end

function prospectd_4sail(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, soil_refl, args...)
    lrt = prospectd(N, Cab, Car, Canth, Cbrown, Cw, Cm)
    foursail_lrt(lrt, soil_refl, LAI, args...)
end

function prospect4_4sailh(N, Cab, Cw, Cm, LAI, soil_moisture_frac, args...)
    prospect4_4sail(N, Cab, Cw, Cm, LAI, hapke_soil(soil_moisture_frac), args...)
end

function prospect5_4sailh(N, Cab, Car, Cw, Cm, LAI, soil_moisture_frac, args...)
    prospect5_4sail(N, Cab, Car, Cw, Cm, LAI, hapke_soil(soil_moisture_frac), args...)
end

function prospect5b_4sailh(N, Cab, Car, Cbrown, Cw, Cm, LAI, soil_moisture_frac, args...)
    prospect5b_4sail(N, Cab, Car, Cbrown, Cw, Cm, LAI, hapke_soil(soil_moisture_frac), args...)
end

function prospectd_4sailh(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, soil_moisture_frac, args...)
    prospectd_4sail(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, hapke_soil(soil_moisture_frac), args...)
end
