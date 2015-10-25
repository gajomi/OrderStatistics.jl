#abstract types
abstract AbstractOrderStatistic{F,S} <: Distribution{F,S}
typealias AbstractScalarOrderStatistic{S} AbstractOrderStatistic{Univariate,S}
typealias AbstractJointOrderStatistic{S} AbstractOrderStatistic{Multivariate,S}

function rand(X::AbstractScalarOrderStatistic)
    samples = sort(rand(X))
    return samples[X.order]
end

function mean(X::AbstractScalarOrderStatistic)
    f = x -> pdf(X,x)*x
    return quadgk(f,minimum(X),maximum(X))[1]#this seems to be rather ill conditioned
end
