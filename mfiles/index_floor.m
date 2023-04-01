function iFloor = index_floor(x, xi);
%
% iFloor = index_floor(x, xi);

if isscalar(x)
  iFloor = (x < xi);
  return;
end

x = x(:);
nx = length(x);

if (min(diff(x)) <= 0), error('X is not sorted or not unique.'); end

sizOut = size(xi);
xi = xi(:);
nxi = length(xi);

% careful when x == xi
[Z, I] = sortrows([xi zeros(nxi, 1); x -ones(nx, 1)]);

Y = sortrows([I -cumsum(Z(:,2))]); 
Y(Y==0) = 0; % to avoid akward '-0'

iFloor = reshape(Y(1:nxi, 2), sizOut);
