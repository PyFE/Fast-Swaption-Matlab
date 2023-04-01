function graph = int_boundary(n1, cc, a0, a1)



if( size(n1, 2) == 2)
    z = -10 : 0.1 : 10;
    
    for i = 1 : length(z)
        d(i)=exac_findbdpt(n1, z(i), cc, a0, a1);
    end

plot(z,d);
%[x,y] = ginput(1);
hold on
graph = plot(x,y, 'mo');
hold off


else
    z1 = [-10 : 0.1 : 10];
    z2 = [-10 : 0.1 : 10];
    [Z1, Z2] = meshgrid(z1, z2);
    
    for i= 1 : length(z1)
        for j = 1 : length(z2)
            d(i, j)=exac_findbdpt3d(n1, z1(i), z2(j), cc, a0, a1);
        end
    end
    
    graph = mesh(Z1, Z2, d);
    
end

  
            
    
   
