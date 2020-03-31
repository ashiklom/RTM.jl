using Serialization: serialize
using DelimitedFiles

# First column is wavelength
refractive_p45 = readdlm("data-raw/refractive_p45.dat", ' ')[:,2]
refractive_pd = readdlm("data-raw/refractive_pd.dat", ' ')[:,2]
kmat_p4 = readdlm("data-raw/kmat_p4.dat", ' ')[:,2:end]
kmat_p5 = readdlm("data-raw/kmat_p5.dat", ' ')[:,2:end]
kmat_pd = readdlm("data-raw/kmat_pd.dat", ' ')[:,2:end]

serialize("data/refractive_p45", refractive_p45)
serialize("data/refractive_pd", refractive_pd)
serialize("data/kmat_p4", kmat_p4)
serialize("data/kmat_p5", kmat_p5)
serialize("data/kmat_pd", kmat_pd)
