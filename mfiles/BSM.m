function result =BSM(Greeks,S,K,sigma,t,T)

% Black-scholes formula of intereste rate derivative

% K=strike, S=forward price, t=time, T=maturity

d1=(log(S/K) + sigma.^2*(T-t)/2)/(sigma*sqrt((T-t)));

d2=d1-sigma*sqrt(T-t);

switch Greeks

    case 'price'
        result = S*normcdf(d1) - K*normcdf(d2);
    
    case 'vega'
        result = S*normpdf(d1)*sqrt(T-t);
end


end