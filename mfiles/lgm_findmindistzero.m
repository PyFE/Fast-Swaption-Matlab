function [d, gradn] = lgm_findmindistzero(cc, a0, a1)
% 
% Find d such that  Sum cc.*exp(-0.5a0 - a1*x) = 0 with |x| is minimized.
%     For N factor LGM model, a0 and a1 are Mx1 and MxN matrices resp. 
%     where M is the number of payoffs.
%
%     d = find_dist(cc, a0, a1, varargin)

maxIter = 32;
maxTor = 100*eps;

dGuess = zeros(1, size(a1, 2));

for kIter = 1:maxIter
    
  val_exp = exp( -( 0.5*a0 + a1*dGuess' ) );
  yy = sum(cc .* val_exp);
  yygrad = -(cc .* val_exp)' * a1;
  
  if(abs(yy) < maxTor) 
      break; 
  end
  
  dGuess = dGuess - yy * yygrad/sum(yygrad.^2);
  
  val_exp = exp( -( 0.5*a0 + a1*dGuess' ) );
  yy = sum(cc .* val_exp);
  yygrad = -(cc .* val_exp)' * a1;

  dGuess = sum(dGuess.*yygrad)/sum(yygrad.^2) * yygrad;
end

if(kIter >= maxIter)
  error('lgm_findmindist: failed to converge.');
else
  d = dGuess;   % normalized gradient. 1 or -1 for 1 factor.
  gradn = yygrad/norm(yygrad, 2);
end
