function y = int_exp(a, x)
%
% Returns int_0^x exp(a*t) dt
%

siz = size(a+x);
y = zeros( siz );
a = a + zeros(siz);
x = x + zeros(siz);

I = ( abs(a) > 1e-10 );


y(I) = (exp(a(I).*x(I)) - 1)./a(I);
y(~I) = x(~I).*(1 + 0.5*a(~I).*x(~I));  %% a가 작으니까 taylor 전개후 적분
