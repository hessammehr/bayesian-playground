using Distributions, Turing, Gadfly
using Mamba: describe

const primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

@model Factor(n) = begin
    N ~ DiscreteUniform(1,10)
    # println(N)
    pr = zeros(Int, N)
    for i in 1:N
        # println(i)
        pr[i] ~ DiscreteUniform(1, length(primes))
    end
    factors = primes[pr]
    prd = *(factors...)
    n ~ DiscreteUniform(prd-1,prd+1)
    println("Factors: $factors, product: $prd, n: $n")
    return factors
end

c = sample(Factor(10), SMC(1000))
describe(c)