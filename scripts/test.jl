using RTM

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

LAI = 3
soil_refl = hapke_soil(0.5)

# PROSPECT + SAIL
p4s = prospect4_4sail(N, Cab, Cw, Cm, LAI, soil_refl)
p5s = prospect5_4sail(N, Cab, Car, Cw, Cm, LAI, soil_refl)
p5bs = prospect5b_4sail(N, Cab, Car, Cbrown, Cw, Cm, LAI, soil_refl)
pds = prospectd_4sail(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, soil_refl)

# PROSPECT + SAIL + hapke
psoil = 0.5
p4s = prospect4_4sailh(N, Cab, Cw, Cm, LAI, psoil)
p5s = prospect5_4sailh(N, Cab, Car, Cw, Cm, LAI, psoil)
p5bs = prospect5b_4sailh(N, Cab, Car, Cbrown, Cw, Cm, LAI, psoil)
pds = prospectd_4sailh(N, Cab, Car, Canth, Cbrown, Cw, Cm, LAI, psoil)
