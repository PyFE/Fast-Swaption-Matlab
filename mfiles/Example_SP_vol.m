%function [price, price_exac, error] = calibration_price(nfactor, strike, freq )



freq = 0.5;
vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];

crv = yldcrv_flat_create(0.055);

optMaturity = [1 2 5   ];
swapMaturity = [1 2 5 10];

cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];

model3 = lgm_create(3, vol_ts, mrv_ts, [0.5 0.2], [-0.8 -0.5], cor3);

swaption = swaption_create(0.06, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);

fwd = swap_fwd(swaption.swap, crv);


vol_ATM = zeros(length(optMaturity),length(swapMaturity));
error_ATM = zeros(length(optMaturity),length(swapMaturity));
vol_ITM = zeros(length(optMaturity),length(swapMaturity));
error_ITM = zeros(length(optMaturity),length(swapMaturity));
vol_OTM = zeros(length(optMaturity),length(swapMaturity));
error_OTM = zeros(length(optMaturity),length(swapMaturity));

n=2;

for k = 1 : length(optMaturity)
    
    for j = 1 : length(swapMaturity)
        
        %At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        %exac = lgm_swaption(swaption, model3, crv,'output','Blvol');
        vol = sp_swaption(swaption, model3, crv, 'output', 'Blvol');
        vol_ATM(k,j)=vol;
        %error_ATM(k,j)=vol-exac;
        
        %%%% In the money %%%%
        
        strike =fwd*0.85;
        %strike =fwd - n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;

        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        %exac = lgm_swaption(swaption, model3, crv,'output','Blvol');
        vol = sp_swaption(swaption, model3, crv, 'output', 'Blvol');
        vol_ITM(k,j)=vol;
        %error_ITM(k,j)=vol-exac;
        
        %%%% Out of the money %%%%
        
        strike = fwd*1.15;
        %strike =fwd + n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;

        
        
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        %exac = lgm_swaption(swaption, model3, crv,'output','Blvol');
        vol = sp_swaption(swaption, model3, crv, 'output', 'Blvol');
        vol_OTM(k,j)=vol;
        %error_OTM(k,j)=vol-exac;
    end
    
end

z=1;

