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
