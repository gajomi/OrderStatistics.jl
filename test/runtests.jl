using Distributions
using IndependentRandomSequences
using OrderStatistics
using Base.Test

# crude ordering tests
N = 5
for X in [Uniform(),Normal()]
  sequence = IIDRandomSequence(X,N)
  Ys = orderstatistics(sequence)
  @test issorted(map(mean,Ys))
  @test mean(Ys[1]) < mean(X)
  @test mean(Ys[end]) > mean(X)
end
