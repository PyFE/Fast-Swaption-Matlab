% price of swaption from our hyperplane model


function price = modelSwaption(x,t,T)
% 3 factor model
% x(1) = vol_ts, x(2), x(3) = volratio, x(4)=mrv_ts, x(5), x(6) =mrvspread,
% x(7),x(8),x(9) = correlation

crv = yldcrv_flat_create(0.055);

vol_ts = [0 x(1); 5 x(1); 20 x(1)];
mrv_ts = [0 x(4); 10 x(4)];


corr = [1 x(7) x(8); x(7) 1 x(9);x(8) x(9) 1];

model = lgm_create(3,vol_ts , mrv_ts ,[x(2) x(3)], [x(5) x(6)], corr);

swaption =swaption_create(0.06, 'rec', t-0.01, t, T, 0.5,'bb',3);

fwd = swap_fwd(swaption.swap,crv);

swaption =swaption_create(fwd, 'rec', t-0.01, t, T, 0.5,'bb',3);

price = lgm_swaption(swaption, model, crv, 'Blvol');






end