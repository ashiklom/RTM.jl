include("RTM.jl")
using .RTM
using Turing
using Distributions

using ForwardDiff
function expint_E1(x::ForwardDiff.Dual)
    RTM.expint_E1(x.value)
end

obs = prospect4(1.4, 40, 0.01, 0.01)[:,1] .+
    Normal()

noise = Normal()

@model fitprospect(obs) = begin
    # Priors
    N ~ Uniform(1.1, 3)
    Cab ~ Uniform(10, 100)
    Cw ~ Uniform(0.001, 0.02)
    Cm ~ Uniform(0.001, 0.02)
    resid ~ InverseGamma(1, 0.2)
    mod = prospect4(N, Cab, Cw, Cm)[:,1]
    for i in 1:length(obs)
        obs[i] ~ Normal(mod[i], resid)
    end
end

chain = sample(fitprospect(obs), NUTS(), 100)
plot(chain)

# chain = sample(fitprospect(obs), NUTS(), 1000)

# c2_alg = Gibbs(MH(:N), MH(:Cab), MH(:Cw), MH(:Cm), :resid)
# c2 = sample(fitprospect(obs), MH(), 1000)

# using Plots
# using StatsPlots
# using Distributions
# plot(InverseGamma(1, 0.2), xlims = (0, 3))

# import Pkg
# Pkg.add("StatsPlots")
