function exac=exac_method(x0, n1, cc, a0, a1)

% n1 is the unit vector of  gradient at x0

int=16/100;

% dimension 1
if( size(x0, 2) == 1)
    exac = sum(cc .* normcdf(-(a1 + ones(size(a0))*x0)*n1'));
    
% dimension 2
elseif( size(x0, 2) == 2)
    n2 = [0 1; -1 0]*n1';
    b1 = a1*n1';
    b2 = a1*n2;

        z = -8 : int : 8 - int ;    

        for j=1:100
            %d0=exac_findbdpt(x0, z(j), cc, a0, a1);
            d0=exac_findbdpt(n1, z(j), cc, a0, a1);
            test_I= 1/sqrt(2*pi) * exp( -0.5*( (b2 + z(j)).^2)) .* normcdf(-(b1 + d0))*int;
            test(j)=sum(cc .* test_I);
        end

    exac=sum(test);

% dimension 3
elseif( size(x0, 2) == 3) 
    n2 = [1 0 0; 0 0 1; 0 -1 0] * n1';
    n3 = [0 1 0; -1 0 0; 0 0 1] * n2 ;

    b1 = a1 * n1';
    b2 = a1 * n2;
    b3 = a1 * n3;

    z1 = -8 : int : 8 - int ;
    z2 = -8 : int : 8 - int ;

    for j=1:100
        for i=1:100
            d0=exac_findbdpt3d(n1, z1(j), z2(i), cc, a0, a1);
            test2_I = 1/(2*pi) * exp( -0.5*( (b3 + z1(j)).^2) -0.5*( (b2 + z2(i)).^2) )  .* normcdf( -b1 - d0) * int*int ;
            test2(i)=sum(cc.*test2_I);
        end
        value(j)=sum(test2);
    end

    exac=sum(value);

end
    
        
