library(JuliaCall)
library(rrtm)
library(testthat)

refractive <- rrtm:::refractive_p45
theta <- 40

tav_r <- rrtm:::tav_abs(theta, refractive)

julia_source("./tav_abs.jl")
tav_jl <- julia_call("tav_abs", theta, refractive)

expect_equal(tav_r, tav_jl)
