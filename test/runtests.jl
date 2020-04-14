using RTM, Test

N = 1.4
Cab = 40
Car = 10
Canth = 8
Cbrown = 0
Cw = 0.01
Cm = 0.01

# PROSPECT
p4 = prospect4(N, Cab, Cw, Cm)
p5 = prospect5(N, Cab, Car, Cw, Cm)
p5b = prospect5b(N, Cab, Car, Cbrown, Cw, Cm)
pd = prospectd(N, Cab, Car, Canth, Cbrown, Cw, Cm)

@test all(p4 .> 0)
@test all(p5 .> 0)
@test all(p5b .> 0)
@test all(pd .> 0)

@test all(p4 .< 1)
@test all(p5 .< 1)
@test all(p5b .< 1)
@test all(pd .< 1)

LAI = 3
soil_refl = hapke_soil(0.5)

@test all(soil_refl .> 0)
@test all(soil_refl .< 1)

# PROSPECT + SAIL
p4s = prospect4_4sail(N, Cab, Cw, Cm, LAI, soil_refl)
@test all(p4s .> 0)
@test all(p4s .< 1)
p5s = prospect5_4sail(N, Cab, Car, Cw, Cm, LAI, soil_refl)
@test all(p5s .> 0)
@test all(p5s .< 1)
p5bs = prospect5b_4sail(N, Cab, Car, Cbrown, Cw, Cm, LAI, soil_refl)
@test all(p5bs .> 0)
@test all(p5bs .< 1)
pds = prospectd_4sail(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, soil_refl)
@test all(pds .> 0)
@test all(pds .< 1)

# PROSPECT + SAIL + hapke
psoil = 0.5
p4s = prospect4_4sailh(N, Cab, Cw, Cm, LAI, psoil)
@test all(p4s .> 0)
@test all(p4s .< 1)
p5s = prospect5_4sailh(N, Cab, Car, Cw, Cm, LAI, psoil)
@test all(p5s .> 0)
@test all(p5s .< 1)
p5bs = prospect5b_4sailh(N, Cab, Car, Cbrown, Cw, Cm, LAI, psoil)
@test all(p5bs .> 0)
@test all(p5bs .< 1)
pds = prospectd_4sailh(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, psoil)
@test all(pds .> 0)
@test all(pds .< 1)
