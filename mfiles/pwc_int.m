function g = pwc_int(x, f, x0, x1)
% Integrate piece-wise constant function
%
% f( [x(i), x(i+1)] ) = f(i)
% g(t) = int_{x0}^{x1} f(t) dt
%
% x0, x1: vectors

sizOut = size(x0+x1);

len0 = length(x0);
x01 = [x0(:); x1(:)];

x = x(:);
f = f(:);

%%%% valuation at x
% used given value if it's passed
%if ~isnan(f)
  gg = [0; cumsum( diff(x).*f(1:end-1) )];
%end

% valuation at [x0 x1]
ind = max(1, index_floor(x, x01));

dx01 = x01 - x(ind);

g01 = gg(ind) + dx01.*f(ind);

g0 = g01(1:len0);
g1 = g01(len0+1:end);

% output
g = g1 - g0;
g = reshape(g, sizOut);
