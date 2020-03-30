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
