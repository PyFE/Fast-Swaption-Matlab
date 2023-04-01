function [yi, xx] = pwc_val(x, y, xi)

x = x(:);
y = y(:);

sizOut = size(xi);
xi = xi(:);

ind = max(1, index_floor(x, xi));

yi = reshape( y(ind), sizOut);    
xx = reshape( x(ind), sizOut);
