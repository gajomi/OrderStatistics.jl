#
# IID case
#
function min(Xs::IIDRandomSequence{Continuous,Exponential})
  N,λ = length(Xs),rate(Xs.d)
  return Exponential(1./(N*λ))
end

function spacing(Xs::IIDRandomSequence,space::Integer)
  N,λ = length(Xs),rate(Xs.d)
  return Exponential(1./((N-space+1)*λs))
end

#
# INID case
#
function min(Xs::INIDRandomSequence{Continuous,Exponential})
  N,λs = length(Xs),[rate(X) for X in Xs.distributions]
  return Exponential(1./sum(λs))
end
