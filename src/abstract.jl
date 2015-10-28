#abstract types
abstract AbstractOrderStatistic{F,S} <: Distribution{F,S}
typealias AbstractScalarOrderStatistic{S} AbstractOrderStatistic{Univariate,S}
typealias AbstractJointOrderStatistic{S} AbstractOrderStatistic{Multivariate,S}
