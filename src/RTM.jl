module RTM
using Serialization: deserialize

export prospect4, prospect5, prospect5b, prospectd,
    foursail, hapke_soil,
    prospect4_4sail, prospect5_4sail, prospect5b_4sail, prospectd_4sail,
    prospect4_4sailh, prospect5_4sailh, prospect5b_4sailh, prospectd_4sailh

# Load PROSPECT data
refractive_p45 = deserialize("data/refractive_p45")
refractive_pd = deserialize("data/refractive_pd")
kmat_p4 = deserialize("data/kmat_p4")
kmat_p5 = deserialize("data/kmat_p5")
kmat_pd = deserialize("data/kmat_pd")
soildat = deserialize("data/soildat")

# Load functions
include("prospect.jl")
include("sail.jl")
include("hapke-soil.jl")
include("pro4sail.jl")

end
