
type OrderStatistic{S,T<:MultivariateDistribution} <: UnivariateDistribution{S}
    sequence::T
    order::Int64
end
function OrderStatistic{S,T}(sequence::IIDRandomSequence{S,T},order::Int64)
    return OrderStatistic{S,IIDRandomSequence{S,T}}(sequence,order)
end

##generic sequences
function rand(X::OrderStatistic)
    samples = sort(rand(X.sequence))
    return samples[X.order]
end

function mean(X::OrderStatistic)
    f = x -> pdf(X,x)*x
    return quadgk(f,minimum(X),maximum(X))[1]#this seems to be rather ill conditioned
end

#IID SEQUENCES
minimum{T<:ContinuousUnivariateDistribution}(X::OrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}) = minimum(X.sequence.d)
maximum{T<:ContinuousUnivariateDistribution}(X::OrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}) = maximum(X.sequence.d)

function cdf{T<:ContinuousUnivariateDistribution}(X::OrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}, x::Real)
  P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return ccdf(Binomial(n,P),k-1)
end

function pdf{T<:ContinuousUnivariateDistribution}(X::OrderStatistic{Continuous,IIDRandomSequence{Continuous,T}}, x::Real)
  P,p,n,k = cdf(X.sequence.d,x), pdf(X.sequence.d,x),length(X.sequence),X.order
  Γ = gamma
  coeff = Γ(n+1)/(Γ(k)*Γ(n-k+1))
  return coeff*P^(k-1)*(1.-P)^(n-k)*p
end

#INID SEQUENCES
function cdf(X::OrderStatistic{Continuous,INIDRandomSequence}, x::Real)
  #P,n,k = cdf(X.sequence.d,x), length(X.sequence), X.order
  return 0 #ccdf(Binomial(n,P),k-1)
end

function pdf(X::OrderStatistic{Continuous,INIDRandomSequence}, x::Real)
  #P,p,n,k = cdf(X.sequence.d,x), pdf(X.sequence.d,x),length(X.sequence),X.order
  #coeff = factorial(n)/(factorial(k-1)*factorial(n-k))
  return 0 #oeff*P^(k-1)*(1.-P)^(n-k)*p
end

function max(Xs::INIDRandomSequence)
  return orderstatistic(Xs,length(Xs))
end
