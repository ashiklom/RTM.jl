include("./RTM.jl")
using .RTM
import RCall
using Plots

# PROSPECT should look like this
refractive = RCall.rcopy(RCall.reval("rrtm:::refractive_p45"))
kmat = RCall.rcopy(RCall.reval("rrtm:::dataspec_p4"))
theta = 40
N = 1.4
k = kmat * [40, 0.01, 0.01] ./ N
rt = RTM.gpm.(k, refractive, N)
rt2 = vcat(rt...)
