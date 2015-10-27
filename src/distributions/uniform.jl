
function orderstatistic(Xs::IIDRandomSequence{Continuous,Uniform},k::Int64)
  if params(Xs.d) == (0.,1.)
    return Beta(k,length(Xs)+1-k)
  else
    error("location/scale aspect not yet implemented")
  end
end

# jointorderstatistics(X::T,k1::Int64,k2::Int64)
# jointorderstatistics(X::T,ks::Vector{Int64})
# jointorderstatistics(X::T)

function range(Xs::IIDRandomSequence{Continuous,Uniform})
  if params(Xs.d) == (0.,1.)
    if length(Xs)>1
      return Beta(length(Xs)-1,2)
    else
      error("sequence must have length greater than 1 for range to exist")
    end
  else
    error("location/scale aspect not yet implemented")
  end
end

# spacings(Y,orders)
