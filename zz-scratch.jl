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
