module TestDistributions

# using Revise
using Test
using MLJInterface
import Distributions

## UNIVARIATE NOMINAL

v = collect("asdfghjklzxc")
d = UnivariateNominal(v, [0.09, 0.02, 0.1, 0.1, 0.1, 0.1, 0.1, 0.11, 0.01, 0.1, 0.07, 0.1])
@test pdf(d, 's') ≈ 0.02
@test mode(d) == 'k'
rand(d, 5)

v = collect("abcd")
d = UnivariateNominal(v, [0.2, 0.3, 0.1, 0.4])
sample = rand(d, 10^4)
freq_given_label = Distributions.countmap(sample)
pairs  = collect(freq_given_label)
sort!(pairs, by=pair->pair[2], alg=QuickSort)
sorted_labels = first.(pairs)
# if this fails it is bug or an exceedingly rare event or a bug:
@test sorted_labels == ['c', 'a', 'b', 'd']
                                                 
d = Distributions.fit(UnivariateNominal, ['a', 'b', 'a', 'b', 'c', 'b', 'a', 'a'])
@test pdf(d, 'a') ≈ 0.5
@test pdf(d, 'b') ≈ 0.375 
@test pdf(d, 'c') ≈ 0.125

end # module

true
