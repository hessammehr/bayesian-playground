# From https://github.com/yebai/Turing.jl/blob/master/example-models/notebooks/Workflow.ipynb

using Turing, Distributions, Gadfly
using Mamba: describe
srand(1234)

x = [(randn(5) .- 5); (randn(5) .+ 5)]

l_x = layer(x=x, y=zeros(length(x)), Geom.point)
plot(l_x)

@model g_simple(x) = begin
    m ~ Normal(0, 100)
    for i = 1:length(x)
        x[i] ~ Normal(m, 1)
    end
end

chn1 = sample(g_simple(x), HMC(1000, 1.5, 10))
chn2 = sample(g_simple(x), PG(10,250))

describe(chn1)