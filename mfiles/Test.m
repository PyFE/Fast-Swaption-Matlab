
function price2 = Test()

vol_ts = [0 0.02; 5 0.03; 20 0.02];
mrv_ts = [0 0.05; 10 0.03];



crv = yldcrv_flat_create(0.05);
swaption = swaption_create(0.06, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);

swap1 = swap_create(2, 10, 0.5, 'bb', 3);
swap2 = swap_create(2,  5, 0.5, 'bb', 3);

model2 = lgm_create(2, vol_ts, mrv_ts, 1.02, 0.03, -0.7);
price2 = lgm_swaption(swaption, model2, crv);
%[price2, exac2, error2] = lgm_swaption(swaption, model2, crv);
%[vol, vol_exac] = lgm_swaption(swaption, model2, crv, 'output', 'vol');
 
%cor3 = [1 0.6 0.2; 0.6 1 0.6; 0.2 0.6 1];
%model3 = lgm_create(3, vol_ts, mrv_ts, [1.02 0.8], [0.03 0.5], cor3);
%[price3, exac3, error3] = lgm_swaption(swaption, model3, crv);




end