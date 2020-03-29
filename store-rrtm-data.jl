using RCall: rcopy, reval
using Serialization: serialize

refractive_p45 = rcopy(reval("rrtm:::refractive_p45"))
refractive_pd = rcopy(reval("rrtm:::refractive_pd"))
kmat_p4 = rcopy(reval("rrtm:::dataspec_p4"))
kmat_p5 = rcopy(reval("rrtm:::dataspec_p5"))
kmat_pd = rcopy(reval("rrtm:::dataspec_pd"))

serialize("data/refractive_p45", refractive_p45)
serialize("data/refractive_pd", refractive_pd)
serialize("data/kmat_p4", kmat_p4)
serialize("data/kmat_p5", kmat_p5)
serialize("data/kmat_pd", kmat_pd)
