function figure = fig_errordensity()

% Example 1
vol_ts = [0 0.03; 0.25 0.024; 0.5 0.024; 1 0.022; 2 0.018; 5 0.012];
mrv_ts = [0 0.115; 5 0.073; 10 0.029 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;

crv = yldcrv_flat_create(0.05);
% crv = new_yldcrv_create(); 

swaption = swaption_create(0.06, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
fwd = swap_fwd(swaption.swap, crv);
swaption = swaption_create(fwd, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);

model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[vol, x1, grad1,cf1,var1,sigma1] = lgm_swaption(swaption, model2, crv, 'output', 'vol');


ITM = fwd - vol*sqrt(1.99)*sqrt(252)/10000;
swaption = swaption_create(ITM, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[price,x2, grad2,cf2,var2,sigma2] = lgm_swaption(swaption, model2, crv);

OTM = fwd + vol*sqrt(1.99)*sqrt(252)/10000;
swaption = swaption_create(OTM, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[price, x3, grad3,cf3,var3,sigma3] = lgm_swaption(swaption, model2, crv);


int=0.2;
z = -6 : int : 6 - int ; 
error1 = int_diff_figure(x1, grad1,cf1,var1,sigma1);
error2 = int_diff_figure(x2, grad2,cf2,var2,sigma2);
error3 = int_diff_figure(x3, grad3,cf3,var3,sigma3);

plot(z,abs(error1),'r-');
hold on
plot(z,abs(error2), 'b*--');
hold on
plot(z,abs(error3),'k.--');



