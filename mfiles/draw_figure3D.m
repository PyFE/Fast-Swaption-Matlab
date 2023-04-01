function figure = draw_figure3D()


vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];

crv = yldcrv_flat_create(0.055);

cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];

swaption = swaption_create(0.06, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
fwd = swap_fwd(swaption.swap, crv);
swaption = swaption_create(fwd, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model3 = lgm_create(3, vol_ts, mrv_ts, [0.5 0.2], [-0.8 -0.5], cor3);

figure = lgm_swaption(swaption, model3, crv, 'output', 'figure');

