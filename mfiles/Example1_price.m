%function [price, price_exac, error] = calibration_price(nfactor, strike, freq )

nfactor=2;
freq=0.5;


% 2 factor example 1
vol_ts = [0 0.03; 0.25 0.024; 0.5 0.024; 1 0.022; 2 0.018; 5 0.012];
mrv_ts = [0 0.115; 5 0.073; 10 0.029 ];   
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;


crv = yldcrv_flat_create(0.05);
optMaturity = [1 2 5 10 20];
swapMaturity = [1 2 5 10 30 ];

 
model2 = lgm_create(nfactor, vol_ts, mrv_ts, volratio, mrvspread, corr);

 
price_ATM = zeros(length(optMaturity),length(swapMaturity));
price_exac_ATM = zeros(length(optMaturity),length(swapMaturity));
error_ATM =zeros(length(optMaturity),length(swapMaturity));

price_ITM = zeros(length(optMaturity),length(swapMaturity));
price_exac_ITM = zeros(length(optMaturity),length(swapMaturity));
error_ITM =zeros(length(optMaturity),length(swapMaturity));

price_OTM = zeros(length(optMaturity),length(swapMaturity));
price_exac_OTM = zeros(length(optMaturity),length(swapMaturity));
error_OTM =zeros(length(optMaturity),length(swapMaturity));



n=1;

for k = 1 : length(optMaturity)
    
    for j = 1 : length(swapMaturity)
        swaption = swaption_create(0.06, 'rec', optMaturity(k)-0.01, optMaturity(k), swapMaturity(j), 0.5, 'bb', 3);
        fwd = swap_fwd(swaption.swap, crv);

        % At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price, price_exac, error] = lgm_swaption(swaption, model2, crv);
        vol = lgm_swaption(swaption, model2, crv, 'output', 'vol');
        
        %express basis point
        price_ATM(k, j) = price*10000;
        price_exac_ATM(k, j) = price_exac*10000;
        error_ATM(k, j) = error*10000;
        
        % In the money
        
        %strike =fwd*0.85;
        
        strike =fwd - n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
        
        
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price_temp1, price_exac_temp1, error_temp1] = lgm_swaption(swaption, model2, crv);
        price_ITM(k, j) = price_temp1*10000;
        price_exac_ITM(k, j) = price_exac_temp1*10000;
        error_ITM(k, j) = error_temp1*10000;

        % Out of the money
        
        %strike = fwd*1.15;
        strike =fwd + n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
        
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [price_temp2, price_exac_temp2, error_temp2] = lgm_swaption(swaption, model2, crv);
        price_OTM(k, j) = price_temp2*10000;
        price_exac_OTM(k, j) = price_exac_temp2*10000;
        error_OTM(k, j) = error_temp2*10000;

    end
    
end

for i=1: length(optMaturity)
    result_ATM(2*i-1,:) = price_ATM(i,:);
    result_ATM(2*i,:) = error_ATM(i,:);
    
    result_ITM(2*i-1,:) = price_ITM(i,:);
    result_ITM(2*i,:) = error_ITM(i,:);
    
    result_OTM(2*i-1,:) = price_OTM(i,:);
    result_OTM(2*i,:) = error_OTM(i,:);
end

debug=0;
