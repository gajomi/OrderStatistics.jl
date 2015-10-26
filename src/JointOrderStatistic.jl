type JointOrderStatistic{D,S<:MultivariateDistribution} <: AbstractJointOrderStatistic{D}
    sequence::S
    orders::Vector{Int64}
end

function JointOrderStatistic{D,S}(sequence::IIDRandomSequence{D,S},orders::Vector{Int64})
    return JointOrderStatistic{D,IIDRandomSequence{D,S}}(sequence,orders)
end

sequence(X::JointOrderStatistic) = X.sequence
orders(X::JointOrderStatistic) = X.orders

length(X::JointOrderStatistic) = length(orders(X))

function _rand!{T<:Real}(X::JointOrderStatistic, x::AbstractVector{T})
  y = sort(rand(sequence(X)))
  x = copy(y[orders(X)])
  return x
end

typealias IIDJointOrderStatistic{D<:ValueSupport,T<:UnivariateDistribution} JointOrderStatistic{D,IIDRandomSequence{D,T}}
typealias IIDContinuousJointOrderStatistic{T<:ContinuousUnivariateDistribution} IIDJointOrderStatistic{Continuous,T}
typealias IIDDiscreteJointOrderStatistic{T<:DiscreteUnivariateDistribution} IIDJointOrderStatistic{Discrete,T}

function _logpdf{T<:Real}(X::IIDContinuousJointOrderStatistic, x::AbstractVector{T})
  N,ks = length(sequence(X)),orders(X)
  logps,Ps = logpdf(X.sequence.d,x),cdf(X.sequence.d,x)
  ΔPs,Δqs = diff([0.;Ps;1.]),diff([0;ks;ks[end]+1])-1
  return lfact(N)+sum(logps)+sum(Δqs.*log(ΔPs))- sum(lfact(Δqs))
end
