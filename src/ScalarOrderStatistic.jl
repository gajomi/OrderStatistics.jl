
type ScalarOrderStatistic{D,S<:MultivariateDistribution} <: AbstractScalarOrderStatistic{D}
    sequence::S
    order::Int64
end

sequence(X::ScalarOrderStatistic) = X.sequence
order(X::ScalarOrderStatistic) = X.order

function rand(X::ScalarOrderStatistic)
    samples = sort(rand(sequence(X)))
    return samples[X.order]
end

function mean(X::ScalarOrderStatistic)
    f = x -> pdf(X,x)*x
    return quadgk(f,minimum(X),maximum(X))[1]#this seems to be rather ill conditioned
end

#
# IID SEQUENCES
#
function ScalarOrderStatistic{D,S}(sequence::IIDRandomSequence{D,S},order::Int64)
    return ScalarOrderStatistic{D,IIDRandomSequence{D,S}}(sequence,order)
end

typealias IIDScalarOrderStatistic{D<:ValueSupport,T<:UnivariateDistribution} ScalarOrderStatistic{D,IIDRandomSequence{D,T}}
typealias IIDContinuousScalarOrderStatistic{T<:ContinuousUnivariateDistribution} IIDScalarOrderStatistic{Continuous,T}
typealias IIDDiscreteScalarOrderStatistic{T<:DiscreteUnivariateDistribution} IIDScalarOrderStatistic{Discrete,T}

# (having probelsm with Discrete/Continuous DRY due to ambiguity creation)
minimum{T<:ContinuousUnivariateDistribution}(X::IIDContinuousScalarOrderStatistic{T}) = minimum(X.sequence.d)
minimum{T<:DiscreteUnivariateDistribution}(X::IIDDiscreteScalarOrderStatistic{T}) = minimum(X.sequence.d)
maximum{T<:ContinuousUnivariateDistribution}(X::IIDContinuousScalarOrderStatistic{T}) = maximum(X.sequence.d)
maximum{T<:DiscreteUnivariateDistribution}(X::IIDDiscreteScalarOrderStatistic{T}) = maximum(X.sequence.d)


function cdf{T<:ContinuousUnivariateDistribution}(X::IIDContinuousScalarOrderStatistic{T}, x::Real)
  P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return ccdf(Binomial(n,P),k-1)
end
function cdf{T<:DiscreteUnivariateDistribution}(X::IIDDiscreteScalarOrderStatistic{T}, x::Int64)
  P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return ccdf(Binomial(n,P),k-1)
end

function pdf{T<:ContinuousUnivariateDistribution}(X::ScalarOrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}, x::Real)
  P,p,n,k = cdf(X.sequence.d,x), pdf(X.sequence.d,x),length(X.sequence),X.order
  coeff = Γ(n+1)/(Γ(k)*Γ(n-k+1))
  return coeff*P^(k-1)*(1.-P)^(n-k)*p
end

#
# INID sequence
#
function ScalarOrderStatistic{D,S}(sequence::INIDRandomSequence{D,S},order::Int64)
    return ScalarOrderStatistic{D,INIDRandomSequence{D,S}}(sequence,order)
end
