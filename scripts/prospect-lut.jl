using RTM

using ProgressMeter

# Nseq = [1.0:0.1:5.0;]
# Cabseq = [0:1:150;]
# Cwseq = [0.001:0.001:0.2;]
# Cmseq = [0.001:0.001:0.2;]

Nseq = [1.0:0.5:3.0;]
Cabseq = [0:10:100;]
Cwseq = [0.001:0.005:0.2;]
Cmseq = [0.001:0.005:0.2;]

function build_prospect_lut(Nseq, Cabseq, Cwseq, Cmseq)
    result = Array{Array{Float32, 2}, 4}(undef, length(Nseq), length(Cabseq),
                                         length(Cwseq), length(Cmseq));
    @showprogress for ii in CartesianIndices(result)
        result[ii] = prospect4(Nseq[ii[1]], Cabseq[ii[2]],
                               Cwseq[ii[3]], Cmseq[ii[4]])
    end
    result
end

prospect_lut_small = build_prospect_lut(Nseq, Cabseq, Cwseq, Cmseq);

function unnest_lut(arr)
    result = Array{Float32, 6}(undef, 2101, 2, size(arr)...)
    for ii in CartesianIndices(arr)
        result[:,:,ii[1],ii[2],ii[3],ii[4]] = arr[ii]
    end
    result
end

function long_lut(arr)
    result = Array{Float32, 2}(undef, prod(size(arr)), 2101)
    idx = CartesianIndices(arr)
    for i in 1:size(result, 1)
        result[i,:] = arr[idx[i]][:,1]
    end
    result
end

prospect_lut_r_long = long_lut(prospect_lut_small)

using Statistics
pvar = var(prospect_lut_r_long, dims = 1)

using Plots
wl = [400:2500;]
plot(wl, pvar[1,:])

using MultivariateStats
pm = fit(PCA, prospect_lut_r_long)
proj = projection(pm)
plot(proj[:,1])
