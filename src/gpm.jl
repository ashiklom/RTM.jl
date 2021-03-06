include("expint.jl")

function gpm(k, refractive, N)
    if k <= 0.0
        trans = 1.0
    elseif k > 85.0
        # Accurate to 1 x 10^-39
        trans = 0.0
    else
        trans = (1 - k) * exp(-k) + k^2 * expint(k)
    end

    # Reflectance/transmittance of a single layer
    talf = tav_abs(40, refractive)
    ralf = 1 - talf
    t12 = tav_abs(90, refractive)
    r12 = 1 - t12
    t21 = t12 / (refractive ^ 2)
    r21 = 1 - t21

    denom = 1 - r21 ^ 2 * trans ^ 2
    Ta = talf * trans * t21 / denom
    Ra = ralf + r21 * trans * Ta

    t = t12 * trans * t21 / denom
    r = r12 + r21 * trans * t

    # Reflectance/transmittance of N layers
    if r + t >= 1
        Tsub = t / (t + (1 - t) * (N - 1))
        Rsub = 1 - Tsub
    else
        D2 = (1 + r + t) * (1 + r - t) * (1 - r + t) * (1 - r - t)
        if D2 < 0
            D2 = 0
        end
        D = sqrt(D2)
        r2 = r ^ 2
        t2 = t ^ 2
        va = (1 + r2 - t2 + D) / (2 * r)
        vb = (1 - r2 + t2 + D) / (2 * t)

        vbNN = vb ^ (N - 1)
        vbNN2 = vbNN ^ 2
        va2 = va ^ 2
        denomx = va2 * vbNN2 - 1
        Rsub = va * (vbNN2 - 1) / denomx
        Tsub = vbNN * (va2 - 1) / denomx
    end

    denomy = 1 - Rsub * r
    RN = Ra + Ta * Rsub * t / denomy
    TN = Ta * Tsub / denomy
   
    [RN TN]
end
