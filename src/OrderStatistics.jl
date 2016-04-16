module OrderStatistics

using Iterators
using Distributions
using IndependentRandomSequences


import Base:length,rand,mean,max,min,maximum,minimum,range,sort
import Distributions:_rand!,pdf,_logpdf,logpdf,cdf,quantile,insupport
import Combinatorics:combinations

export AbstractOrderStatistic,AbstractScalarOrderStatistic,AbstractJointOrderStatistic,
      ScalarOrderStatistic,JointOrderStatistic,
      parentsequence,order,orders,
      orderstatistic,orderstatistics,jointorderstatistic,jointorderstatistics,
      spacing,spacings,jointspacing,jointspacing

include("abstract.jl")
include("helpers.jl")
include("ScalarOrderStatistic.jl")
include("JointOrderStatistic.jl")
include("generic.jl")

dnames = ["uniform","exponential"]
for dname in dnames
    include(joinpath("distributions", "$(dname).jl"))
end


end # module
