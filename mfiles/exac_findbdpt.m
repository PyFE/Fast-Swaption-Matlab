function d = exac_findbdpt(n1, z, cc, a0, a1)

% x0 is the point whose distance from the origin is the minimum among on the surface  f(x)=0

maxIter = 32;
maxTor = 100*eps;

%theta=atan2(x0(1),x0(2));
theta=atan2(n1(1),n1(2));

dGuess = 0 ;

for kIter = 1:maxIter
    
    val_exp=exp(-(0.5*a0 + a1(:,1) .* (cos(theta)*z + sin(theta) * dGuess) + a1(:,2) .* (-sin(theta) *z + cos(theta)*dGuess) ));
    fx=sum(cc .* val_exp);
    fxgrad= (cc .* val_exp)' * ( -a1(:,1)*sin(theta) - a1(:,2)*cos(theta) );
    
    if(abs(fx) < maxTor)
       break;
    end
    
    dGuess= dGuess - fx/fxgrad;
    
end

if(kIter > maxIter)
    error('exac_findbdpt : failed to converge.');
else
    d=dGuess;
end
    
    
    
    
    
    
    
    