function refltrans(lai, ks, ko,
                   rho, tau, att, m, sigb, sf, sb, vf, vb)

    e1    = exp(-m * lai)
    e2    = e1 * e1
    rinf  = (att - m) / sigb
    rinf2 = rinf * rinf
    re    = rinf * e1
    denom = 1.0 - rinf2 * e2

    J1ks = Jfunc1(ks, m, lai)
    J2ks = Jfunc2(ks, m, lai)
    J1ko = Jfunc1(ko, m, lai)
    J2ko = Jfunc2(ko, m, lai)

    Ps    = (sf + sb * rinf) * J1ks
    Qs    = (sf * rinf + sb) * J2ks
    Pv    = (vf + vb * rinf) * J1ko
    Qv    = (vf * rinf + vb) * J2ko

    rdd   = rinf*(1.0 - e2)    / denom
    tdd   = (1.0 - rinf2) * e1 / denom
    tsd   = (Ps - re * Qs)     / denom
    rsd   = (Qs - re * Ps)     / denom
    tdo   = (Pv - re * Qv)     / denom
    rdo   = (Qv - re * Pv)     / denom

    tss   = exp(-ks*lai)
    too   = exp(-ko*lai)
    z     = Jfunc2(ks,ko,lai)
    g1    = (z-J1ks*too)/(ko+m)
    g2    = (z-J1ko*tss)/(ks+m)

    # Multiple-scattering contribution to reflectance
    Tv1   = (vf * rinf + vb) * g1
    Tv2   = (vf + vb * rinf) * g2
    T1    = Tv1 * (sf + sb * rinf)
    T2    = Tv2 * (sf * rinf + sb)
    T3    = (rdo * Qs + tdo * Ps) * rinf
    rsod  = (T1 + T2 - T3) / (1 - rinf2)

    rdd, tdd, tsd, rsd, tdo, rdo, tss, too, rsod
end

function Jfunc1(k, l, t)
    del = (k - l) * t
    if abs(del) > 1e-3
        (exp(-l*t) - exp(-k*t)) / (k - l)
    else
        0.5t * (exp(-k * t) + exp(-l*t)) * (1 - (del^2) / 12)
    end
end

function Jfunc2(k, l, t)
    (1 - exp(-(k + l) * t)) / (k + l)
end
