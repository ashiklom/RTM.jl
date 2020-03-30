function tav_abs(theta, refractive)
    if theta == 0
        result = 4 * refractive / (refractive + 1) ^ 2
        return result
    end

    # Convert angle to radians
    thetarad = π * theta / 180.0

    refr2 = refractive ^ 2
    refr2p1 = refr2 + 1
    refr2p12 = refr2p1 * refr2p1
    refr2p13 = refr2p12 * refr2p1
    refr2m12 = (refr2 - 1) ^ 2

    ax = 0.5 * (refractive + 1) ^ 2
    bx = -0.25 * refr2m12

    if thetarad == π / 2.0
        b1 = 0
    else
        b1 = sqrt(bx + (sin(thetarad)^2 - 0.5 * refr2p1)^2)
    end

    b2 = sin(thetarad) ^ 2 - 0.5 * refr2p1
    b0 = b1 - b2
    ts = (bx^2 / (6 * b0^3) + bx / b0 - b0 / 2) -
        (bx^2 / (6 * ax^3) + bx / ax - ax / 2)
    tp1 = -2 * refr2 * (b0 - ax) / refr2p12
    tp2 = -2 * refr2 * refr2p1 * log(b0 / ax) / refr2m12
    tp3 = refr2 * 0.5 * (1 / b0 - 1 / ax)
    tp4 = 16 * refr2 ^ 2 * (refr2 ^ 2 + 1) *
        log((2 * refr2p1 * b0 - refr2m12) /
            (2 * refr2p1 * ax - refr2m12)) /
            (refr2p13 * refr2m12)
    tp5 = 16 * refr2 ^ 3 *
        (1 / (2 * refr2p1 * b0 - refr2m12) - 1 /
         (2 * refr2p1 * ax - refr2m12)) / refr2p13
    tp = tp1 + tp2 + tp3 + tp4 + tp5

    (ts + tp) / (2 * sin(thetarad) ^ 2)
end
