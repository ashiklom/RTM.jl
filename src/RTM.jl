module RTM
using Serialization: deserialize

export prospect4, prospect5, prospect5b, prospectd,
    foursail, hapke_soil,
    prospect4_4sail, prospect5_4sail, prospect5b_4sail, prospectd_4sail,
    prospect4_4sailh, prospect5_4sailh, prospect5b_4sailh, prospectd_4sailh

# Load PROSPECT data
here = @__DIR__
const refractive_p45 = deserialize(here * "/data/refractive_p45")
const refractive_pd = deserialize(here * "/data/refractive_pd")
const kmat_p4 = deserialize(here * "/data/kmat_p4")
const kmat_p5 = deserialize(here * "/data/kmat_p5")
const kmat_pd = deserialize(here * "/data/kmat_pd")
const soildat = deserialize(here * "/data/soildat")

# Load functions
include("prospect.jl")
include("sail.jl")
include("hapke-soil.jl")
include("pro4sail.jl")

end
