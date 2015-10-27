using Distributions
using IndependentRandomSequences
using OrderStatistics
using Base.Test

#
#Quantitative tests for Uniform Case
#
N = 5
U = Uniform()
sequence = IIDRandomSequence(U,N)

#scalar order statistics
Vs = orderstatistics(sequence)
@test map(mean,Vs) == collect(1:5)/6

#joint order statistics


#
# Qualitative ordering tests
#
N = 5
for X = [Uniform(),Normal()]
  sequence = IIDRandomSequence(X,N)

  #scalar order statistics
  Ys = orderstatistics(sequence)
  @test issorted(map(mean,Ys))
  @test mean(Ys[1]) < mean(X)
  @test mean(Ys[end]) > mean(X)

  #joint order statistics
  jYs = jointorderstatistics(sequence)
  for jY=jYs
    @test issorted(rand(jY))
  end

end
