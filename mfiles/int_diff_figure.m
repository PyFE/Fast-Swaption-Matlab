function error = int_diff_figure(x0, n1, cc, a0, a1)


%int=16/100;
int=0.2;

n2 = [0 1; -1 0]*n1';
b1 = a1*n1';
b2 = a1*n2;

theta=atan2(n1(1),n1(2));
d = [cos(theta) -sin(theta);sin(theta) cos(theta)] * x0';

z = -6 : int : 6 - int ;    
exac = zeros(size(z));
fastcalib = zeros(size(z));

for j=1:length(z)
    d0=exac_findbdpt(n1, z(j), cc, a0, a1);
    exac_temp= 1/sqrt(2*pi) * exp( -0.5*( (b2 + z(j)).^2)) .* normcdf(-(b1 + d0));
    fastcalib_temp = 1/sqrt(2*pi) * exp( -0.5*( (b2 + z(j)).^2)) .* normcdf(-(b1 + d(2)));
    exac(j) = sum(cc .*exac_temp);
    fastcalib(j) = sum(cc .* fastcalib_temp);
    error(j) =fastcalib(j) - exac(j)  ;
end

% plot(z, exac, 'r*-');
% hold on;
% plot(z, fastcalib, 'bo-');

%plot(z, error, 'r*-');
