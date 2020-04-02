include("./RTM.jl")
using .RTM

p4 = prospect4(1.4, 40, 0.01, 0.01)
p4N = prospect4.(
    [1.1:0.1:2.0;],
    40,
    0.01,
    0.01
)

using Plots

p4N_refl = hcat([x[:,1] for x in p4N]...)
plot(p4N_refl)

##################################################
ForwardDiff.Dual()

# Cab = 40
# Cw = 0.01
# Cm = 0.01
# N = 1.4
# k = RTM.kmat_p4 * cc

# rt = zeros(Float64, (2101, 2))
# for i in 1:2101
#     rt[i,:] = RTM.gpm(k[i], RTM.refractive_p45[i], N)
# end

##################################################
include("src/lidf.jl")
y = dcum.(0.5, 0.5, 10:5:80)

##################################################
include("src/volscatt.jl")
angles = [-60:10:60;]

chi_s, chi_o, frho, ftau = (zeros(Float64, length(angles), length(angles), length(angles), length(angles))
         for _ in 1:4);

for idx in CartesianIndices(chi_s)
    chi_s[idx], chi_o[idx], frho[idx], ftau[idx] =
        volscatt(angles[idx[1]], angles[idx[2]], angles[idx[3]], angles[idx[4]])
end

##################################################
# PRO4SAIL example
using RTM
lrt = prospect4(1.4, 40, 0.01, 0.01)
canopy = vcat(foursail.(lrt[:,1], lrt[:,2], 0.1, 3, 0.9, 0, 0, 0)...)

##################################################
using Serialization

wl = [400:2500;]

refractive_p45 = deserialize("data/refractive_p45")
refractive_pd = deserialize("data/refractive_pd")
kmat_p4 = deserialize("data/kmat_p4")
kmat_p5 = deserialize("data/kmat_p5")
kmat_pd = deserialize("data/kmat_pd")

using DelimitedFiles
writedlm("data-raw/refractive_p45.dat", hcat(wl, refractive_p45), " ")
writedlm("data-raw/refractive_pd.dat", hcat(wl, refractive_pd), " ")
writedlm("data-raw/kmat_p4.dat", hcat(wl, kmat_p4), " ")
writedlm("data-raw/kmat_p5.dat", hcat(wl, kmat_p5), " ")
writedlm("data-raw/kmat_pd.dat", hcat(wl, kmat_pd), " ")
##################################################

include("src/suits.jl")
include("src/rtgeom.jl")
include("src/refltrans.jl")
include("src/hotspot.jl")
include("src/volscatt.jl")
include("src/lidf.jl")

leaf_refl =  0.04108688
leaf_trans = 0.0006602529
lrt = [leaf_refl leaf_trans]
soil_refl = 0.2377
LAI = 3
hot_spot = 0.01
solar_zenith = 30
instrument_zenith = 10
azimuth = 0

tts = solar_zenith
tto = instrument_zenith
psi = solar_zenith
litab = Array{Float64}(vcat([5:10:75;], [81:2:89;]))
F_lidf = dcum.(-0.35, -0.15, litab)
lidf = vcat(F_lidf[1], diff(F_lidf))
lidf = F_lidf
ttl = litab[1]
