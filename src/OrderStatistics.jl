module OrderStatistics

using Distributions
using IndependentRandomSequences

import Base:length,rand,mean,max,min,maximum,minimum
import Distributions:_rand!,pdf,_logpdf,logpdf,cdf,quantile,insupport

export AbstractOrderStatistic,AbstractScalarOrderStatistic,AbstractJointOrderStatistic,
      ScalarOrderStatistic,JointOrderStatistic,
      sequence,order,orders,
      orderstatistic,orderstatistics,jointorderstatistic

include("abstract.jl")
include("helpers.jl")
include("ScalarOrderStatistic.jl")
include("JointOrderStatistic.jl")
include("generic.jl")

dnames = ["uniform"]
for dname in dnames
    include(joinpath("distributions", "$(dname).jl"))
end


end # module
