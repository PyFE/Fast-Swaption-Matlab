function result = impBLvol(method,MP,S,K,t,T)


maxTor = 1e-6;
maxIter = 100;
    
switch method
    
    % Newton-Rapson method
    case 'Newton'

    vol=0.2;    % initial value of sigma
%     volStep = 1;

    for kIter = 1:maxIter
        
        Blprice = BSM('price',S,K,vol,t,T);
        vega = BSM('vega',S,K,vol,t,T);
        
        priceError = Blprice - MP;
        
        if ( abs(priceError) < maxTor)
            break;
%         elseif (priceError <0 )
%             vol = vol + 0.05*volStep; % step back 5% of previous increment
            
        else
            vol = vol - priceError/vega;
%             volStep = priceError/vega;
            
        end
        
    end
    
    if (kIter<maxIter)
        result = vol;
    else
        warning('Newton method failed within %d iterations, error: %e',kIter, priceError);
    end
    
    
    
    % Bisection method
    
    case 'Bisection'
        
        v_low =0.01;
        v_high = 0.2;
        
      
        
        vi = (v_low + v_high)/2;
        
        f = BSM('price',S,K,vi,t,T) - MP;
        
        while abs( f ) > maxTor;
            
            if (BSM('price',S,K,v_low,t,T) - MP)*(BSM('price',S,K,vi,t,T) - MP) <0
                
                v_high = vi;
            else 
                v_low = vi;
            end
            
            vi = (v_low + v_high)/2;
            f = BSM('price',S,K,vi,t,T) - MP;
            
        end
        result = vi;
        
end

            
           

end