function hotspot(lai, q, tss, ks, ko, dso)
    alf = 1e6
    if q > 0
        alf = (dso/q) * 2 / (ks + ko)
    end
    if alf > 200
        alf = 200
    end
    if alf == 0
        tsstoo = tss
        sumint = (1 - tss) / (ks * lai)
    else
        #Outside the hotspot
        fhot   = lai*sqrt(ko*ks)

        #Integrate by exponential Simpson method in 20 steps
        #the steps are arranged according to equal partitioning
        #of the slope of the joint probability function
        x1     = 0.
        y1     = 0.
        f1     = 1.
        ca     = exp(-alf)
        fint   = 0.5 * (1 - ca)
        sumint = 0.

        for i in 1:20
            if i < 20
                x2 = -log(1 - i*fint)/alf
            else
                x2=1.
            end
            y2     = -(ko+ks)*lai*x2+fhot*(1 - exp(-alf*x2))/alf
            f2     = exp(y2)
            sumint = sumint+(f2-f1)*(x2-x1)/(y2-y1)
            x1     = x2
            y1     = y2
            f1     = f2
        end
       
        tsstoo = f1
    end
    tsstoo, sumint
end
