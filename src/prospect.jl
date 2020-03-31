include("tav_abs.jl")
include("gpm.jl")

function gpm_k(k, refractive, N)
    rt = gpm.(k, refractive, N)
    vcat(rt...)
end

function prospect4(N, Cab, Cw, Cm)
    cc = [Cab, Cw, Cm] ./ N
    k = kmat_p4 * cc
    gpm_k(k, refractive_p45, N)
end

function prospect5b(N, Cab, Car, Cbrown, Cw, Cm)
    cc = [Cab, Car, Cbrown, Cw, Cm] ./ N
    k = kmat_p5 * cc
    gpm_k(k, refractive_p45, N)
end

function prospect5(N, Cab, Car, Cw, Cm)
    # Set Cbrown to zero
    Cbrown = 0
    prospect5b(N, Cab, Car, Cbrown, Cw, Cm)
end

function prospectd(N, Cab, Car, Canth, Cbrown, Cw, Cm)
    cc = [Cab, Car, Canth, Cbrown, Cw, Cm] ./ N
    k = kmat_pd * cc
    gpm_k(k, refractive_pd, N)
end
