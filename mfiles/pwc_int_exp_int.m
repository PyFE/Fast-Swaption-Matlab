function F = pwc_int_exp_int(t, h, f, t0, t1, t2)
%
% f(t(i) < t < t(i+1)) = f(t)
%
% F(t) = int_t1^t2 h(t) exp( int_t0^t f(s) ds ) dt;
%
% g(t) = int_t0^t f(s) ds
% 
% t0: scalar
% t1, t2: vector

t = t(:);
f = f(:);
if isempty(h)
  h = ones(size(f));
elseif isscalar(h)
    h = h*ones(size(f));
else
  h = h(:);
end

sizOut = size(t1+t2);

len1 = length(t1);
t12 = [t1(:); t2(:)];

g = pwc_int(t, f, t0, t);

dt = diff(t);
dF = h(1:end-1) .* exp(g(1:end-1)) .* int_exp(f(1:end-1), dt); 
F = [0; cumsum(dF)];

% valuation at ti
ind = max(1, index_floor(t, t12));

dt12 = t12 - t(ind);
dF12 = zeros( size(dt12) );
F12 = F(ind);

h12 = h(ind);
g12 = g(ind);
f12 = f(ind);

dF12 = h12 .* exp(g12) .* int_exp( f12, dt12 );

F12 = F(ind) + dF12;

F0 = F12(1:len1);
F1 = F12(len1+1:end);

% output
F = reshape(F1 - F0, sizOut);
