
% 2 factor Example 2 vol.

nfactor=2;
freq=0.5; 

%2 factor example 2
vol_ts = [0 0.02; 0.25 0.014; 0.5 0.013; 1 0.012; 2 0.01; 5 0.009];
mrv_ts = [0 -0.051; 5 0.059; 10 0.017 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;


crv = new_yldcrv_create();
optMaturity = [ 1 2 5 10 ];
swapMaturity = [1 2 5 10  ];

model2 = lgm_create(nfactor, vol_ts, mrv_ts, volratio, mrvspread, corr);   %2-dim

 

vol_ATM = zeros(length(optMaturity),length(swapMaturity));


vol_ITM = zeros(length(optMaturity),length(swapMaturity));


vol_OTM = zeros(length(optMaturity),length(swapMaturity));



n=0.5;

for k = 1 : length(optMaturity)

    for j = 1 : length(swapMaturity)
        
        swaption = swaption_create(0.06, 'rec', optMaturity(k)-0.01, optMaturity(k), swapMaturity(j), 0.5, 'bb', 3);
        fwd = swap_fwd(swaption.swap, crv);

        % At the monney   strike=fwd
        strike = fwd ;
        swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
        vol = lgm_swaption(swaption, model2, crv, 'output', 'Blvol');
        vol_ATM(k, j) = vol;
       

        % In the money

%         strike =fwd*0.85;
%         
% 
% 
%         swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
%         vol_temp1 = lgm_swaption(swaption, model2, crv, 'output', 'Blvol');
%         vol_ITM(k, j) = vol_temp1;
%         
% 
%         % Out of the money
% 
%         strike = fwd*1.15;
%         
% 
%         swaption = swaption_create(strike, 'rec', optMaturity(k)-0.01 , optMaturity(k), swapMaturity(j), freq, 'bb', 3);
%         vol_temp2 = lgm_swaption(swaption, model2, crv, 'output', 'Blvol');
%         vol_OTM(k, j) = vol_temp2;
%        

    end

end

debug=0;