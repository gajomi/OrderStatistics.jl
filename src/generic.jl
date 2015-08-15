
orderstatistic{S<:IIDRandomSequence}(Xs::S,k::Int64) = OrderStatistic(Xs,k)
orderstatistic{S<:INIDRandomSequence}(Xs::S,k::Int64) = OrderStatistic(Xs,k)
orderstatistic{T<:ContinuousUnivariateDistribution}(X::T,n::Int64,k::Int64) = orderstatistic(IIDRandomSequence(X,n),k)

orderstatistics{S<:IIDRandomSequence}(Xs::S) = [orderstatistic(Xs,k) for k = 1:length(Xs)]
orderstatistics{S<:INIDRandomSequence}(Xs::S) = [orderstatistic(Xs,k) for k = 1:length(Xs)]
orderstatistics{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = orderstatistics(IIDRandomSequence(X,n))

min(Xs::IIDRandomSequence) = orderstatistic(Xs,1)
min{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = min(IIDRandomSequence(X,n))

max(Xs::IIDRandomSequence) = orderstatistic(Xs,length(Xs))
max{T<:ContinuousUnivariateDistribution}(X::T,n::Int64) = max(IIDRandomSequence(X,n))

# jointorderstatistics(X::S,k1::Int64,k2::Int64) #prefer instead
# jointorderstatistics(X::S,ks::Vector{Int64})
# jointorderstatistics(X::S)

# range(Y::JointOrderStatistic)
# spacings(Y,orders)
