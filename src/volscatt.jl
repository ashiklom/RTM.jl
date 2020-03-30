function volscatt(solar_zenith, instrument_zenith, azimuth, leaf_angle)
    d2r = π / 180.0

    # Sun-sensor geoms
    costs = cos(d2r * solar_zenith)
    sints = sin(d2r * solar_zenith)
    costo = cos(d2r * instrument_zenith)
    sinto = sin(d2r * instrument_zenith)
    cospsi = cos(d2r * azimuth)
    psirad = d2r * azimuth

    # Leaf geoms
    costl = cos(d2r * leaf_angle)
    sintl = sin(d2r * leaf_angle)

    cs = costl * costs
    co = costl * costo
    ss = sintl * sints
    so = sintl * sinto

    # Transition angles (beta) for solar (bts) and instrument (bto) directions
    cosbts = 5
    if abs(ss) > 1e-6
        cosbts = -cs / ss
    end
    cosbto = 5
    if abs(so) > 1e-6
        cosbto = -co / so
    end

    if abs(cosbts) < 1
        bts = acos(cosbts)
        ds = ss
    else
        bts = pi
        ds = cs
    end


    chi_s = 2/π * ((bts - 0.5π) * cs + sin(bts) * ss)

    if abs(cosbto) < 1
        bto = acos(cosbto)
        doo = so
    elseif instrument_zenith < 90
        bto = pi
        doo = co
    else
        bto = 0
        doo = -co
    end

    chi_o = 2/π * ((bto - 0.5π) * co + sin(bto) * so)

    # Auxiliary azimuth angles bt1, bt2, bt3, for bidirectional scattering
    btran1 = abs(bts - bto)
    btran2 = π - abs(bts + bto - pi)

    if psirad < btran1
        bt1 = psirad
        bt2 = btran1
        bt3 = btran2
    else
        bt1 = btran1
        if (psirad < btran2)
            bt2 = psirad
            bt3 = btran2
        else
            bt2 = btran2
            bt3 = psirad
        end
    end

    t1 = 2cs * co + ss * so * cospsi
    t2 = 0
    if bt2 > 0
        t2 = sin(bt2) * (2ds * doo + ss * so * cos(bt1) * cos(bt3))
    end

    denom = 2(π^2)
    frho = ((pi - bt2) * t1 + t2) / denom
    ftau = (-bt2 * t1 + t2) / denom
    if frho < 0
        frho = 0
    end
    if ftau < 0
        ftau = 0
    end

    chi_s, chi_o, frho, ftau

end
