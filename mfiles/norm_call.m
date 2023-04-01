function [call, varargout] = ...
    norm_call(strk, fwd, T, volNorm)

% calculates call option price of normal model.
% 
% call = norm_call(strk, fwd, T, volNorm)

if (volNorm<0), error('volNorm should be positive'); end

sqrtT = sqrt(T);
d = (fwd-strk)./(sqrtT.*volNorm);

nd = normpdf(d);
Nd = normcdf(d);

call = sqrtT.*volNorm.*(nd + d.*Nd);
