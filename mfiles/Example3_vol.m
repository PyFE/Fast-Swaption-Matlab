%function price = calibration_vol_3F( )

freq=0.5;
vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];

crv = yldcrv_flat_create(0.055);

% optMaturity = [1 2 5 10 20];
% swapMaturity = [1 2 5 10 30  ];

optMaturity = [1/12 0.25 0.5 1 2 3 4 5 7 10 15 20 ];
swapMaturity = [ 1 3 5 6 7 8 9 10 15 20  ];

cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];

model3 = lgm_create(3, vol_ts, mrv_ts, [0.5 0.2], [-0.8 -0.5], cor3);

swaption = swaption_create(0.06, 'rec', 4.99, 5, 10, 0.5, 'bb', 3);

fwd = swap_fwd(swaption.swap, crv);

vol_ATM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_ATM = zeros(length(optMaturity),length(swapMaturity));
error_ATM =zeros(length(optMaturity),length(swapMaturity));

vol_ITM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_ITM = zeros(length(optMaturity),length(swapMaturity));
error_ITM =zeros(length(optMaturity),length(swapMaturity));

vol_OTM = zeros(length(optMaturity),length(swapMaturity));
vol_exac_OTM = zeros(length(optMaturity),length(swapMaturity));
error_OTM =zeros(length(optMaturity),length(swapMaturity));

n=2;

for k = 1 : length(optMaturity)

    for j = 1 : length(swapMaturity)
        
        

        % At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        vol= lgm_swaption(swaption, model3, crv, 'output', 'vol');
        vol_ATM(k, j) = vol;
%         vol_exac_ATM(k, j) = vol_exac;
%         error_ATM(k, j) = error;
% 
%         % In the money
% 
%         %strike =fwd*0.85;
%         strike =fwd - n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
% 
% 
%         swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
%         [vol_temp1, vol_exac_temp1, error_temp1] = lgm_swaption(swaption, model3, crv, 'output', 'vol');
%         vol_ITM(k, j) = vol_temp1;
%         vol_exac_ITM(k, j) = vol_exac_temp1;
%         error_ITM(k, j) = error_temp1;
% 
%         % Out of the money
% 
%         %strike = fwd*1.15;
%         strike =fwd + n*vol*sqrt(optMaturity(k)-0.01)./10000 * sqrt(252) ;
% 
%         swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
%         [vol_temp2, vol_exac_temp2, error_temp2] = lgm_swaption(swaption, model3, crv, 'output', 'vol');
%         vol_OTM(k, j) = vol_temp2;
%         vol_exac_OTM(k, j) = vol_exac_temp2;
%         error_OTM(k, j) = error_temp2;

    end

end

debug=0;
