function prospect4(N, Cab, Cw, Cm)
    cc = [Cab, Cw, Cm] ./ N
    k = kmat_p4 * cc
    rt = gpm.(k, refractive_p45, N)
    vcat(rt...)
end
