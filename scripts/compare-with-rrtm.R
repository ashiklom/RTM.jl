library(JuliaCall)
library(rrtm)
library(testthat)

refractive <- rrtm:::refractive_p45
theta <- 40

tav_r <- rrtm:::tav_abs(theta, refractive)

julia_source("./tav_abs.jl")
tav_jl <- julia_call("tav_abs.", theta, refractive)

expect_equal(tav_r, tav_jl)

# Test GPM
julia_eval("using GSL: sf_expint_E1")
julia_source("./gpm.jl")

kmat <- rrtm:::dataspec_p4
N <- 1.4
k <- kmat %*% c(40, 0.01, 0.01) / N
gpm_r <- rrtm:::gpm(k, refractive, N)
gpm_r_refl <- gpm_r[,,1]
gpm_r_trans <- gpm_r[,,2]

gpm_jl <- julia_call("gpm.", k, refractive, N)
gpm_jl_refl <- numeric(2101)
gpm_jl_trans <- numeric(2101)
for (i in seq_len(2101)) {
  gpm_jl_refl[i] <- gpm_jl[i][[1]]
  gpm_jl_trans[i] <- gpm_jl[i][[2]]
}

expect_equal(gpm_jl_refl, gpm_r_refl)
expect_equal(gpm_jl_trans, gpm_r_trans)
