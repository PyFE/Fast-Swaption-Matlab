

% real exercise boundary & 95% CI & 99% CI

function p = lgm_exercise_boundary(n1,cc,a0,a1)



    int = 16/100;

    n2 = [0 1; -1 0]*n1';
    b1 = a1*n1';
    b2 = a1*n2;
    
    
    
    z = -8 : int : 8 - int ;    

    

    for j=1:100
        
         d0(j)=exac_findbdpt(n1, z(j), cc, a0, a1);
        
        
        
    end
    
    
    d =exac_findbdpt(n1, 0, cc, a0, a1);
    
    d= ones(size(z))*d;
    
    plot(z,d0,'-');
    
    hold on
    
    plot(z,d,'r*');
    
    hold on
    
    
    
    theta = 0 : 0.01 : 2*pi;
    r1 = 1.96;                % 95% confidence interval
    r2 = 2.5758;              % 99%
    x1 = r1 * cos(theta) ;
    y1 = r1 * sin(theta) ;
    plot(x1, y1,'m');
    x2 = r2 * cos(theta) ;
    y2 = r2 * sin(theta) ;
    p=plot(x2, y2,'g');
    xlabel('y1');
    ylabel('y2');
    %title(['Strike =', num2str(K),   ',  sigama = ', num2str(sig)]);
    legend('exercise boudary', 'approximation', '95% CI', '99% CI');
    grid on;

end


