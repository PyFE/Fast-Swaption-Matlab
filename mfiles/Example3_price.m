%function [price, price_exac, error] = calibration_price(nfactor, strike, freq )



freq = 0.5;
vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];

crv = yldcrv_flat_create(0.055);

optMaturity = [1 2 5 10 20];
swapMaturity = [1 2 5 10 30];

cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];

model3 = lgm_create(3, vol_ts, mrv_ts, [0.5 0.2], [-0.8 -0.5], cor3);

swaption = swaption_create(0.06, 'rec', 4.99, 5, 10, 0.5, 'bb', 3);

fwd = swap_fwd(swaption.swap, crv);

price_ATM = zeros(length(optMaturity),length(swapMaturity));
price_exac_ATM = zeros(length(optMaturity),length(swapMaturity));
error_ATM =zeros(length(optMaturity),length(swapMaturity));

price_ITM = zeros(length(optMaturity),length(swapMaturity));
price_exac_ITM = zeros(length(optMaturity),length(swapMaturity));
error_ITM =zeros(length(optMaturity),length(swapMaturity));

price_OTM = zeros(length(optMaturity),length(swapMaturity));
price_exac_OTM = zeros(length(optMaturity),length(swapMaturity));
error_OTM =zeros(length(optMaturity),length(swapMaturity));



n=2;

for k = 1 : length(optMaturity)
    
    for j = 1 : length(swapMaturity)
        
        % At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price, price_exac, error] = lgm_swaption(swaption, model3, crv);
        vol = lgm_swaption(swaption, model3, crv, 'output', 'vol');
        
        %express basis point
        price_ATM(k, j) = price*10000;         
        price_exac_ATM(k, j) = price_exac*10000;
        error_ATM(k, j) = error*10000;

        % In the money
        
        %strike =fwd*0.85;
        
        strike =fwd - n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
        
        
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price_temp1, price_exac_temp1, error_temp1] = lgm_swaption(swaption, model3, crv);
        price_ITM(k, j) = price_temp1*10000;
        price_exac_ITM(k, j) = price_exac_temp1*10000;
        error_ITM(k, j) = error_temp1*10000;

        % Out of the money
        
        %strike = fwd*1.15;
        strike =fwd + n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
        
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price_temp2, price_exac_temp2, error_temp2] = lgm_swaption(swaption, model3, crv);
        price_OTM(k, j) = price_temp2*10000;
        price_exac_OTM(k, j) = price_exac_temp2*10000;
        error_OTM(k, j) = error_temp2*10000;

    end
    
end

z=1;