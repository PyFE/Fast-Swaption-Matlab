function [strd, vega, volga] = ...
    norm_strd_vega(strk, fwd, T, volNorm)

% calculates straddle price (and vega, volga) of normal model.
% 
% [strd, vega, volga] = norm_strd_vega(strk, fwd, T, volNorm)

sqrtT = sqrt(T);
d = (fwd-strk)./(sqrtT.*volNorm);

nd = normpdf(d);
Nd = normcdf(d);

strd = 2*sqrtT.*volNorm.*nd + (fwd-strk).*(2*Nd-1);

if (nargout > 1)
    vega = 2*sqrtT*nd;
end

if (nargout > 2)
    volga = 2*d.^2.*sqrtT./volNorm.*nd;
end
