# OrderStatistics

A package for working with [order statistics](https://en.wikipedia.org/wiki/Order_statistic) of random variables.

## Installation
This module is not yet registered. To install run
```julia
Pkg.clone("https://github.com/gajomi/IndependentRandomSequences.jl")
Pkg.clone("https://github.com/gajomi/OrderStatistics.jl")
```

##Basic usage

### High level api

The high level api is defined by a collection of methods for computing order statistics of different kinds of random variables. The basic breakdown is
* `orderstatistic`- returns a univariate marginal order statistic
* `min`/`max` returns the minimum or maximum order statistic
* `range`  returns the difference between the minimum and maximum
* `spacing`  returns the marginal spacing between adjacent order statistics, which includes the maximum/minimum of the support in the case that they are finite

Some of these methods have analogs that return the joint distributions

* `jointorderstatistic` - returns a multivariate joint order statistic (full or marginal)
* `jointspacing` - returns a multivariate joint order statistic (full or marginal)

There are also plural analogs that serve as convenience methods for iterating over collections of order statistics

* `orderstatistics`,`jointorderstatistics`,
`spacings`,`jointspacings`

At present only independent random sequences (IID/INID) from `IndependentRandomSequences.jl` are supported as the distribution type. Most of these methods support a variety of signatures. See method documentation for usage.

### Example

```julia
using Distributions
using IndependentRandomSequences
using OrderStatistics

U,N = Uniform(),3
sequence = IIDRandomSequence(U,N)
Vs = orderstatistics(sequence)

>>>3-element Array{Distributions.Beta,1}:
    Distributions.Beta(α=1.0, β=3.0)
    Distributions.Beta(α=2.0, β=2.0)
    Distributions.Beta(α=3.0, β=1.0)

jointspacing(sequence)

>>>Distributions.Dirichlet(alpha=[1.0,1.0,1.0,1.0])

Es = [Exponential(1./rate) for rate=1:3]
sequence = INIDRandomSequence(Es)
minE = min(sequence)

>>>Distributions.Exponential(θ=0.16666666666666666)
```

### Colorful Example

```julia
X,N = Normal(),3
sequence = IIDRandomSequence(X,N)
Zs = orderstatistics(sequence);

trials = 2^15
samples = [rand(Z,trials) for Z in Zs]
nedges = 64
edges = linspace(-3,3,nedges)
xx = linspace(-3,3,256)
oshists = [hist(samples[k],edges)[2]/trials for k= 1:N]
empiricalpdfs=[layer(x=midpoints(edges),y=nedges*oshist/(edges[end]-edges[1]),
                Geom.point,Theme(default_color=c)) for (oshist,c) in zip(oshists,colors)]
theorypdfs = [layer(x=xx,y = [pdf(Z,x) for x in xx],
                    Geom.line,Theme(default_color=c)) for (Z,c) in zip(Zs,colors)]

empiricalcdfs=[layer(x=midpoints(edges),y=cumsum(oshist),
                Geom.point,Theme(default_color=c)) for (oshist,c) in zip(oshists,colors)]
theorycdfs = [layer(x=xx,y = [cdf(Z,x) for x in xx],
                    Geom.line,Theme(default_color=c)) for (Z,c) in zip(Zs,colors)]

set_default_plot_size(20cm, 8cm)
hstack(plot(empiricalpdfs...,theorypdfs...,
        Guide.XLabel("x"), Guide.YLabel("probablity density"),gajomitheme),
plot(empiricalcdfs...,theorycdfs...,
        Guide.XLabel("x"), Guide.YLabel("cumulative probability"),gajomitheme))
```

![Image of Yaktocat](https://github.com/gajomi/OrderStatistics.jl/blob/master/funplot.png)

### Low level API (subject to change)

The high level api make it possible to return order statistic quantities in the form of types "known" to Julia through the `Distributions` package (and perhaps others). When such a "known" type is no available, a call is made to the low level api, which makes a call a generic fallback types: `ScalarOrderStatistic` and `JointOrderStatistic`.

#Contributing

### Know an analytical result not included here?
The easy way to contribute to the module is to write instances of the high level api methods that return (correct) results as ordinary `Distribution` types. These methods should be type stable (i.e. a change in the distribution parameters or order shouldn't change the returned type). Correct results might not be obvious to the casual observer, so if you can include a citation that outlines a derivation that would be appreciated.

### Roadmap to 0.1

There are currently many holes in the basic fallback functionality. Check out the [roadmap to 0.1](https://github.com/gajomi/OrderStatistics.jl/issues/5) to get a sense for this.

### Inferential statistics

At present the focus of this package is entirely on the probabilistic aspects of order statistics. However, as the name suggests, they are an important part of non-parametric statistics. For those with a vision of what this would looking like, please fork the repo! If you are interested in a specific limited bit of functionality related to inference please open an issue with your feature request.


[![Build Status](https://travis-ci.org/gajomi/OrderStatistics.jl.svg?branch=master)](https://travis-ci.org/gajomi/OrderStatistics.jl)
