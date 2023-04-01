function z3 = exac_findbdpt3d(n1, z1, z2, cc, a0, a1)

maxIter = 32;
maxTor = 100*eps;

z3 = 0;
z = [z1 z2 z3];
n1 = n1/norm(n1);

c2 = n1(3);                  % s2, c2 are sin(pi), cos(pi)
s2 = sqrt(1 - c2.^2);
c1 = n1(1)/s2;               % s1, c1 are sin(90-theta), cos(90-theta)
s1 = sqrt(1 - c1.^2);

Mz = [1 0 0; 0 c2 -s2; 0 s2 c2];       % rotate on yz plane
My = [s1 -c1 0; c1 s1 0; 0 0 1];       % rotate on xy plane

rot_z = inv(My)*inv(Mz)*z';    % rotate z to catesian coordinate

for kIter = 1:maxIter
    
    val_exp = exp(-(0.5*a0 + a1 * rot_z));
    fx = sum(cc .* val_exp);
    diff_fx = -(cc .* val_exp)' * ( a1(:,1)*c1*s2 + a1(:,2)*s1*s2 + a1(:,3)* c2 );
    
    if(abs(fx) < maxTor)
        break;
    end
    
    z3 = z3 - fx/diff_fx;
    rot_z = inv(My)*inv(Mz)*[z1, z2, z3]';
    


if(kIter > maxIter)
    error('exac_findbdpt : failed to converge.');
end

end

end