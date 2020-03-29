# rtm.jl: Radiative transfer modeling in Julia

Implementations of common plant leaf and canopy radiative transfer models in Julia.

## Examples

Run the PROSPECT 4 leaf RTM.

``` julia
using RTM

p4 = prospect4(1.4, 40, 0.01, 0.01)
```

Use Julia's built-in broadcasting to do quick sensitivity analyses, for instance.

``` julia
p4N = prospect4.(
  [1.1:0.1:2.0;],
  40,
  0.01,
  0.01
)
```
