module RTM
using Serialization: deserialize

export prospect4
export foursail

# Load PROSPECT data
refractive_p45 = deserialize("data/refractive_p45")
refractive_pd = deserialize("data/refractive_pd")
kmat_p4 = deserialize("data/kmat_p4")
kmat_p5 = deserialize("data/kmat_p5")
kmat_pd = deserialize("data/kmat_pd")

# PROSPECT functions
include("prospect.jl")
include("sail.jl")

include("gpm.jl")
include("prospect.jl")
end
