# OrderStatistics

A package for working with [order statistics](https://en.wikipedia.org/wiki/Order_statistic) of random variables.

##Basic usage

### High level api

The high level api is defined by a collection of methods for computing order statistics of different kinds of random variables. For example to compute the marginal (scalar) order statistics of an iid random sequence one can write:

```julia
using Distributions
using IndependentRandomSequences
using OrderStatistics

X,N = Uniform(),3
Ys = orderstatistics(IIDRandomSequence(X,N))

>>> 3-element Array{Beta,1}:
      Beta(α=1.0, β=3.0)
      Beta(α=2.0, β=2.0)
      Beta(α=3.0, β=1.0)

max(IIDRandomSequence(X,N))

>>> Beta(α=3.0, β=1.0)

```
Pattern for INID

The methods ``orderstatistic``, ``max`` and ``min`` can all dispatch based on the type of the random sequence, which allows them to return analytical result when known. The method ``orderstatistics`` returns all order statistics computed by ``orderstatistic``.

### Low level API (subject to change)

When there is no special analytical result known, these methods rely on a generic fallback, which currently creates ``ScalarOrderStatistic`` types:

```julia
X,N = Normal(),3
Y = orderstatistic(IIDRandomSequence(X,N),2)

>>> OrderStatistic{Continuous,IIDRandomSequence{Continuous,Normal}}(
    sequence: IIDRandomSequence{Continuous,Normal}(
      d: Normal(μ=0.0, σ=1.0)
      length: 3)
    order: 2)
```

In addition to continuous there is discrete

## Additional methods

The module also exports the following methods related to order statistics:

* ``range`` - returns the distribution describing the difference between the maximum and minimum values
* ``spacing`` and ``spacings`` - return scalar or joint spacing(s) between values

## Inferential statistics

At present the focus of this package is entirely on the probabilistic aspects of order statistics. However, as the name suggests, they are an important aspect of non-parametric statistics. For those with a vision of what this would looking like, please fork the repo! If you are interested in a specific limited bit of functionality related to inference please open an issue with your feature request.

[![Build Status](https://travis-ci.org/gajomi/OrderStatistics.jl.svg?branch=master)](https://travis-ci.org/gajomi/OrderStatistics.jl)
