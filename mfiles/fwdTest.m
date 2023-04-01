tic
start = 2;
freq = 0.5;
tenor = 10;
vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];

crv = yldcrv_flat_create(0.055);

cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];

model3 = lgm_create(3, vol_ts, mrv_ts, [0.5 0.2], [-0.8 -0.5], cor3);

swaption = swaption_create(0.0558, 'rec', start-0.01, start, tenor, freq, 'bb', 3);
% fwd = swap_fwd(swaption.swap, crv);
%         
%         
% strike = fwd ;
% swaption = swaption_create(strike, 'rec', start-0.01, start, tenor, freq, 'bb', 3);
%[vol, vol_exac, error] = lgm_swaption(swaption, model3, crv, 'output', 'vol');
vol= lgm_swaption(swaption, model3, crv);
toc

