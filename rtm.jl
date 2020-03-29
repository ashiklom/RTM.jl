module RTM
using Serialization: deserialize

export prospect4

# Load PROSPECT data
refractive_p45 = deserialize("data/refractive_p45")
refractive_pd = deserialize("data/refractive_pd")
kmat_p4 = deserialize("data/kmat_p4")
kmat_p5 = deserialize("data/kmat_p5")
kmat_pd = deserialize("data/kmat_pd")

# Source functions
include("tav_abs.jl")
include("gpm.jl")
include("prospect.jl")
end
