function rtgeom(rho, tau, ddb, ddf, sdb, sdf, dob, dof, sob, sof)
    # NOTE: Assume rho and tau are scalar here
   
    sigb = ddb * rho + ddf * tau
    sigf = ddf * rho + ddb * tau
    att  = 1. - sigf
    m2   = (att + sigb) * (att - sigb)

    if m2 < 0
        m2 = 0
    end

    m  = sqrt(m2)
    sb = sdb * rho + sdf * tau
    sf = sdf * rho + sdb * tau
    vb = dob * rho + dof * tau
    vf = dof * rho + dob * tau
    w  = sob * rho + sof * tau
   
    sigb, att, m, sb, sf, vb, vf, w
end
