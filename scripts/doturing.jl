include("RTM.jl")
using .RTM
using Turing
using Distributions
using ForwardDiff

function prospect4(N, Cab, Cw, Cm)
    RTM.prospect4(N, Cab, Cw, Cm)
end

function prospect4(
    N::ForwardDiff.Dual,
    Cab::ForwardDiff.Dual,
    Cw::ForwardDiff.Dual,
    Cm::ForwardDiff.Dual,
)
    RTM.prospect4(N.value, Cab.value, Cw.value, Cm.value)
end

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

obs = prospect4(1.4, 40, 0.01, 0.01)[:,1]

# Very fast, but extremely inefficient. Algorithm may not be adaptive-enough?
chain = sample(fitprospect(obs), MH(), 5000)

# Visualize the chains
using Plots
using StatsPlots
plot(chain)

# Very efficient, but slow sampling. Need to figure out how to speed it up.
# Probably related to automatic differentiation.
chain2 = sample(fitprospect(obs), NUTS(), 100)
plot(chain2)

# See Turing documentation: https://turing.ml/dev/docs/using-turing/guide
