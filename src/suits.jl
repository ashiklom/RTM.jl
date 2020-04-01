function suits(litab, lidf, tts, tto, cts, cto, psi, ctscto)

    d2r = π/180

    # Calculate geometric factors associated with extinction and scattering

    # Initialise sums
    ks  = 0
    ko  = 0
    bf  = 0
    sob = 0
    sof = 0

    for i in 1:length(litab)
        ttl = litab[i]
        ctl = cos(d2r * ttl)
        chi_s, chi_o, frho, ftau = volscatt(tts, tto, psi, ttl)

        #********************************************************************************
        #*                   SUITS SYSTEM COEFFICIENTS
        #*
        #*	ks  : Extinction coefficient for direct solar flux
        #*	ko  : Extinction coefficient for direct observed flux
        #*	att : Attenuation coefficient for diffuse flux
        #*	sigb : Backscattering coefficient of the diffuse downward flux
        #*	sigf : Forwardscattering coefficient of the diffuse upward flux
        #*	sf  : Scattering coefficient of the direct solar flux for downward diffuse flux
        #*	sb  : Scattering coefficient of the direct solar flux for upward diffuse flux
        #*	vf   : Scattering coefficient of upward diffuse flux in the observed direction
        #*	vb   : Scattering coefficient of downward diffuse flux in the observed direction
        #*	w   : Bidirectional scattering coefficient
        #********************************************************************************

        ksli = chi_s / cts
        koli = chi_o / cto

        sobli = frho*π/ctscto
        sofli = ftau*π/ctscto
        bfli  = ctl*ctl
        ks    += ksli*lidf[i]
        ko    += koli*lidf[i]
        bf    += bfli*lidf[i]
        sob   += sobli*lidf[i]
        sof   += sofli*lidf[i]
    end

    sdb = 0.5 * (ks + bf)
    sdf = 0.5 * (ks - bf)
    dob = 0.5 * (ko + bf)
    dof = 0.5 * (ko - bf)
    ddb = 0.5 * (1. + bf)
    ddf = 0.5 * (1. - bf)
    
    ks, ko, sob, sof, sdb, sdf, dob, dof, ddb, ddf
end
