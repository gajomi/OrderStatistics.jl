
function orderstatistic(Xs::IIDRandomSequence{Continuous,Uniform},k::Int64)
  if params(Xs.d) == (0.,1.)
    return Beta(k,length(Xs)+1-k)
  else
    error("location/scale aspect not yet implemented")
  end
end

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

function spacing(Xs::IIDRandomSequence{Continuous,Uniform},space::Integer)
  if params(Xs.d) == (0.,1.)
    if length(Xs)>1
      return Beta(1,length(Xs))
    else
      error("sequence must have length greater than 1 for range to exist")
    end
  else
    error("location/scale aspect not yet implemented")
  end
end

function jointspacing(Xs::IIDRandomSequence{Continuous,Uniform})
  if params(Xs.d) == (0.,1.)
    if length(Xs)>1
      return Dirichlet(length(Xs)+1,1)
    else
      error("sequence must have length greater than 1 for range to exist")
    end
  else
    error("location/scale aspect not yet implemented")
  end
end
