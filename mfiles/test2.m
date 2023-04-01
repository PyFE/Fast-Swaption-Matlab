% 2 factor example 1
vol_ts = [0 0.03; 0.25 0.024; 0.5 0.024; 1 0.022; 2 0.018; 5 0.012];
mrv_ts = [0 0.115; 5 0.073; 10 0.029 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;

crv = yldcrv_flat_create(0.05);
swaption = swaption_create(0.06, 'rec', 0.99, 1, 10, 0.5, 'bb', 3);
fwd = swap_fwd(swaption.swap, crv);
swaption = swaption_create(fwd, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);

model2 = lgm_create(2, vol_ts, mrv_ts, 1.05, 0.27, -0.77);
[vol, vol_exac] = lgm_swaption(swaption, model2, crv, 'output', 'vol');
