function exac3=exac_method3d(x0, n1, cc, a0, a1)

M=size(a1, 1);
int=16/100;

n2 = [1 0 0; 0 0 1; 0 -1 0] * n1';
n3 = [0 1 0; -1 0 0; 0 0 1] * n2 ;

b1 = a1 * n1';
b2 = a1 * n2;
b3 = a1 * n3;

z1 = -8 : int : 8 - int ;
z2 = -8 : int : 8 - int ;

for j=1:100
    for i=1:100
        d0=exac_findbdpt3d(x0, z1(j), z2(i), cc, a0, a1);
        test2_I = 1/(2*pi) * exp( -0.5*( (b3 + z1(j)).^2) -0.5*( (b2 + z2(i)).^2) )  .* normcdf( -b1 - d0) * int*int ;
        test2(i)=sum(cc.*test2_I);
    end
    value(j)=sum(test2);
end

exac3=sum(value);
        
            
            
        
       


