
function min(Xs::IIDRandomSequence{Continuous,Exponential})
  N,λ = length(Xs),rate(Xs.d)
  return Exponential(N*λ)
end

function min(Xs::INIDRandomSequence{Continuous,Exponential})
  N,λs = length(Xs),[rate(X) for X in sequence(X)]
  return Exponential(N*sum(λs))
end
