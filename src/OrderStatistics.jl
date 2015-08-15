module OrderStatistics

using Distributions
using IndependentRandomSequences

import Base:length,rand,mean,max,min,maximum,minimum
import Distributions:pdf,logpdf,cdf,quantile,insupport

export orderstatistic,orderstatistics,
        OrderStatistic

include("ScalarOrderStatistic.jl")
include("generic.jl")

dnames = ["uniform"]
for dname in dnames
    include(joinpath("distributions", "$(dname).jl"))
end


end # module
