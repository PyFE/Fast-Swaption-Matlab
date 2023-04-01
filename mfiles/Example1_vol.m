%function [vol, vol_exac, error] = calibration_vol(nfactor, strike, freq )

nfactor=2;
freq=0.5; 

% 2 factor example 1
vol_ts = [0 0.03; 0.25 0.024; 0.5 0.024; 1 0.022; 2 0.018; 5 0.012];
% vol_ts = [0 0.3; 0.25 0.24; 0.5 0.24; 1 0.22; 2 0.18; 5 0.12];
mrv_ts = [0 0.115; 5 0.073; 10 0.029 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;
 
 
crv = yldcrv_flat_create(0.05);

% co-terminal 10year
optMaturity = [ 1 2 5 10 20 ];
swapMaturity = [ 1 2 5 10 20];

 
model2 = lgm_create(nfactor, vol_ts, mrv_ts, volratio, mrvspread, corr);   %2-dim
%model2 = lgm_create(3, vol_ts, mrv_ts, [1.02 0.8], [0.03 0.5], corr);       % 3-dim
 

vol_ATM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_ATM = zeros(length(optMaturity),length(swapMaturity));
error_ATM =zeros(length(optMaturity),length(swapMaturity));

vol_ITM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_ITM = zeros(length(optMaturity),length(swapMaturity));
error_ITM =zeros(length(optMaturity),length(swapMaturity));

vol_OTM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_OTM = zeros(length(optMaturity),length(swapMaturity));
error_OTM =zeros(length(optMaturity),length(swapMaturity));



n=1;

for k = 1 : length(optMaturity)

    for j = 1 : length(swapMaturity)
        
        swaption = swaption_create(0.06, 'rec', optMaturity(k)-0.01, optMaturity(k), swapMaturity(j), 0.5, 'bb', 3);
        fwd = swap_fwd(swaption.swap, crv);

        % At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [vol, vol_exac,error] = lgm_swaption(swaption, model2, crv, 'output', 'vol');
        vol_ATM(k, j) = vol;
        vol_exac_ATM(k, j) = vol_exac;
        error_ATM(k, j) = error;

        % In the money

%         strike =fwd*0.85;
%         strike =fwd - n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
% 
% 
%         swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
%         [vol_temp1, vol_exac_temp1, error_temp1] = lgm_swaption(swaption, model2, crv, 'output', 'vol');
%         vol_ITM(k, j) = vol_temp1;
%         vol_exac_ITM(k, j) = vol_exac_temp1;
%         error_ITM(k, j) = error_temp1;
% 
%         % Out of the money
% 
%         strike = fwd*1.15;
        strike =fwd + n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;

        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        [vol_temp2, vol_exac_temp2, error_temp2] = lgm_swaption(swaption, model2, crv, 'output', 'vol');
        vol_OTM(k, j) = vol_temp2;
        vol_exac_OTM(k, j) = vol_exac_temp2;
        error_OTM(k, j) = error_temp2;

    end

end

debug=0;





