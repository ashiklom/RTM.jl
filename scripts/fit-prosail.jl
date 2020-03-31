using RTM

out = pro4sail.(1.4, 40, 0.01, 0.01, [1:0.5:7;], 0.3)
dhr = mapreduce(x -> x[:,1], hcat, out)

using Plots

wl = [400:2500;]
plot(wl, dhr)
