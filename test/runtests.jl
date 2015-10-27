using Distributions
using IndependentRandomSequences
using OrderStatistics
using Base.Test

Γ = gamma

#
#Quantitative tests for Uniform Case
#
for N = 3:5
  U = Uniform()
  sequence = IIDRandomSequence(U,N)

  #scalar order statistics
  Vs = orderstatistics(sequence)
  @test map(mean,Vs) == collect(1:N)/(N+1)

  #joint order statistics
  fulljoint = jointorderstatistic(sequence)
  @test_approx_eq_eps(pdf(fulljoint,collect(1:N)/(N+1)),Γ(N+1),10^3*eps())
  for n=2:N
    for orders=combinations(N,n)
      @test mean(jointorderstatistic(sequence,orders)) == orders/(N+1)
    end
  end

  #range
  @test mean(range(sequence)) == (N-1)/(N+1)
end



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
