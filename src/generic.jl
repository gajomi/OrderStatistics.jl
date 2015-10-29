#
# univariate orderstatistic methods
#
orderstatistic(Xs::MultivariateDistribution,k::Int64) = ScalarOrderStatistic(Xs,k)
function orderstatistic{T<:ContinuousUnivariateDistribution}(X::T,n::Integer,k::Integer)
  return orderstatistic(IIDRandomSequence(X,n),k)
end

orderstatistics(Xs::MultivariateDistribution) = [orderstatistic(Xs,k) for k = 1:length(Xs)]
orderstatistics{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = orderstatistics(IIDRandomSequence(X,n))

#
# joint order statistic methods
#
jointorderstatistic(X::MultivariateDistribution,orders::Vector{Int64}) = JointOrderStatistic(X,orders)
jointorderstatistic(X::MultivariateDistribution) = jointorderstatistic(X,collect(1:length(X)))
function jointorderstatistic(X::JointOrderStatistic)
  fullorders = collect(1:length(X))
  if orders(X) == fullorders
    return X
  else
    error('not yet implemented (coming soon though)')
  end
end

function jointorderstatistics(X::MultivariateDistribution,n::Integer)
  return imap(orders->jointorderstatistic(X,orders),combinations(1:length(X),n))
end
function jointorderstatistics(X::MultivariateDistribution)
  N = length(X)
  ordercombos = chain([combinations(1:N,k) for k=2:N]...)
  return imap(orders->jointorderstatistic(X,orders),ordercombos)
end

#
# max/min methods
#
min(Xs::MultivariateDistribution) = orderstatistic(Xs,1)
min{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = min(IIDRandomSequence(X,n))

max(Xs::MultivariateDistribution) = orderstatistic(Xs,length(Xs))
max{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = max(IIDRandomSequence(X,n))

#
# range methods
#
function range(Y::MultivariateDistribution)
  error("No generic implementation available at this time")
end

#
# spacing methods
#
function spacing(Y::MultivariateDistribution,space::Integer)
  error("No generic implementation available at this time")
end

spacings(Y::MultivariateDistribution) = [spacing(Y,space) for space = 1:length(Y)+1]

function jointspacing(Y::MultivariateDistribution,spaces::Vector{Integer})
  error("No generic implementation available at this time")
end

function jointspacings(X::MultivariateDistribution)
  N = length(X)+1
  spacecombos = chain([combinations(1:N,k) for k=2:N]...)
  return imap(orders->jointspacing(X,spaces),spacecombos)
end
