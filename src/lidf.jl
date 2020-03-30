# Leaf inclination distribution function from Verhoef dissertation
# a,b LIDF parameters
# theta Angle (degrees)
function dcum(a, b, theta)
    d2r = π/180.0
    θ = theta * d2r
    x = 2θ
    x0 = x
    t = 1e-6
    dx_abs = 1
    y = undef
    while dx_abs > t
        y = a * sin(x) + 0.5b * sin(2x)
        dx = 0.5(y - x + x0)
        x = x + dx
        dx_abs = abs(dx)
    end
    2 * (y + θ)/π
end
