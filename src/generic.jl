
orderstatistic{S<:IIDRandomSequence}(Xs::S,k::Int64) = ScalarOrderStatistic(Xs,k)
orderstatistic{S<:INIDRandomSequence}(Xs::S,k::Int64) = ScalarOrderStatistic(Xs,k)
function orderstatistic{T<:ContinuousUnivariateDistribution}(X::T,n::Integer,k::Integer)
  return orderstatistic(IIDRandomSequence(X,n),k)
end

orderstatistics{S<:IIDRandomSequence}(Xs::S) = [orderstatistic(Xs,k) for k = 1:length(Xs)]
orderstatistics{S<:INIDRandomSequence}(Xs::S) = [orderstatistic(Xs,k) for k = 1:length(Xs)]
orderstatistics{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = orderstatistics(IIDRandomSequence(X,n))

min(Xs::IIDRandomSequence) = orderstatistic(Xs,1)
min{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = min(IIDRandomSequence(X,n))

max(Xs::IIDRandomSequence) = orderstatistic(Xs,length(Xs))
max{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = max(IIDRandomSequence(X,n))

jointorderstatistic(X::IIDRandomSequence,orders::Vector{Int64}) = JointOrderStatistic(X,orders)
jointorderstatistic(X::IIDRandomSequence,k1::Int64,k2::Int64) = jointorderstatistic(X,[k1,k2])
jointorderstatistic(X::IIDRandomSequence) = jointorderstatistic(X,collect(1:length(X)))

function jointorderstatistics(X::AbstractJointOrderStatistic,n::Integer)
  return imap(orders->jointorderstatistic(X,orders),combinations(1:length(sequence(X)),n))
end
function jointorderstatistics(X::AbstractJointOrderStatistic)
  N = length(sequence(X))
  ordercombos = chain([combinations(1:N,k) for k=2:N]...)
  return imap(orders->jointorderstatistic(X,orders),ordercombos)
end

# range(Y::JointOrderStatistic)
# spacings(Y,orders)
