
type ScalarOrderStatistic{D,S<:MultivariateDistribution} <: AbstractScalarOrderStatistic{D}
    sequence::S
    order::Int64
end
function ScalarOrderStatistic{D,S}(sequence::IIDRandomSequence{D,S},order::Int64)
    return ScalarOrderStatistic{D,IIDRandomSequence{D,S}}(sequence,order)
end

typealias IIDScalarOrderStatistic{D<:ValueSupport,T<:UnivariateDistribution} ScalarOrderStatistic{D,IIDRandomSequence{D,T}}
typealias IIDContinuousScalarOrderStatistic{T<:ContinuousUnivariateDistribution} IIDScalarOrderStatistic{Continuous,T}
typealias IIDDiscreteScalarOrderStatistic{T<:DiscreteUnivariateDistribution} IIDScalarOrderStatistic{Discrete,T}

#IID SEQUENCES (having probelsm with Discrete/Continuous DRY due to ambiguity creation)
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
  Γ = gamma
  coeff = Γ(n+1)/(Γ(k)*Γ(n-k+1))
  return coeff*P^(k-1)*(1.-P)^(n-k)*p
end
