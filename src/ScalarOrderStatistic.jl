
type ScalarOrderStatistic{F,T<:MultivariateDistribution} <: AbstractScalarOrderStatistic{F}
    sequence::T
    order::Int64
end
function ScalarOrderStatistic{F,T}(sequence::IIDRandomSequence{F,T},order::Int64)
    return ScalarOrderStatistic{F,IIDRandomSequence{F,T}}(sequence,order)
end

#IID SEQUENCES
minimum{T<:ContinuousUnivariateDistribution}(X::ScalarOrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}) = minimum(X.sequence.d)
maximum{T<:ContinuousUnivariateDistribution}(X::ScalarOrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}) = maximum(X.sequence.d)

function cdf{T<:ContinuousUnivariateDistribution}(X::ScalarOrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}, x::Real)
  P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return ccdf(Binomial(n,P),k-1)
end

function pdf{T<:ContinuousUnivariateDistribution}(X::ScalarOrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}, x::Real)
  P,p,n,k = cdf(X.sequence.d,x), pdf(X.sequence.d,x),length(X.sequence),X.order
  Γ = gamma
  coeff = Γ(n+1)/(Γ(k)*Γ(n-k+1))
  return coeff*P^(k-1)*(1.-P)^(n-k)*p
end

#INID SEQUENCES
function cdf(X::ScalarOrderStatistic{Continuous,INIDRandomSequence}, x::Real)
  #P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return 0 #ccdf(Binomial(n,P),k-1)
end

function pdf(X::ScalarOrderStatistic{Continuous,INIDRandomSequence}, x::Real)
  #P,p,n,k = cdf(X.sequence.d,x), pdf(X.sequence.d,x),length(X.sequence),X.order
  #coeff = factorial(n)/(factorial(k-1)*factorial(n-k))
  return 0 #oeff*P^(k-1)*(1.-P)^(n-k)*p
end

function max(Xs::INIDRandomSequence)
  return ScalarOrderStatistic(Xs,length(Xs))
end
