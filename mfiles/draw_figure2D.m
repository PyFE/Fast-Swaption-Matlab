function figure = draw_figure2D()

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
%figure = lgm_swaption(swaption, model2, crv, 'output', 'figure');
vol = lgm_swaption(swaption, model2, crv, 'output', 'vol');

% for i = 1:5
%     strike(i) = fwd +0.5 * (i-1) * vol*sqrt(1.99)*sqrt(252)/10000;
%     swaption = swaption_create(strike(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
%     model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
%     [price, grad, cf, var, sigma] = lgm_swaption(swaption, model2, crv);
%     
%     z = -6 : 0.1 : 6;
% 
%     for j = 1 : length(z)
%         d(j)=exac_findbdpt(grad,z(j),cf,var,sigma);     
%     end
%     
%     plot(z,d,'--');
% 	hold on 
%     
% end

    
strike1 = fwd - vol*sqrt(1.99)*sqrt(252)/10000;
swaption = swaption_create(strike1, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[price,grad1,cf1,var1,sigma1] = lgm_swaption(swaption, model2, crv);

strike2 = fwd 
swaption = swaption_create(strike2, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[price,grad2,cf2,var2,sigma2] = lgm_swaption(swaption, model2, crv);

strike3 = fwd + vol*sqrt(1.99)*sqrt(252)/10000;
swaption = swaption_create(strike3, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
[price,grad3,cf3,var3,sigma3] = lgm_swaption(swaption, model2, crv);

% strike4 = fwd + vol*sqrt(1.99)*sqrt(252)/10000;
% swaption = swaption_create(strike4, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
% model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
% [price,grad4,cf4,var4,sigma4] = lgm_swaption(swaption, model2, crv);
% 
% strike5 = fwd + 1.5* vol*sqrt(1.99)*sqrt(252)/10000;
% swaption = swaption_create(strike5, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
% model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);
% [price,grad5,cf5,var5,sigma5] = lgm_swaption(swaption, model2, crv);

z = -6 : 0.2 : 6;

for i = 1 : length(z)
    d1(i)=exac_findbdpt(grad1,z(i),cf1,var1,sigma1);
    d2(i)=exac_findbdpt(grad2,z(i),cf2,var2,sigma2);
    d3(i)=exac_findbdpt(grad3,z(i),cf3,var3,sigma3);
%     d4(i)=exac_findbdpt(grad4,z(i),cf4,var4,sigma4);
%     d5(i)=exac_findbdpt(grad5,z(i),cf5,var5,sigma5);
end


% plot(z,d1,'r');
% hold on
% [x,y] = ginput(1);
% hold on
% plot(x,y, 'ko');
% 
% plot(z,d2, 'b');
% [x2,y2] = ginput(1);
% hold on
% plot(x2,y2, 'ko');
% 
% hold on
% plot(z,d3,'m');
% [x3,y3] = ginput(1);
% hold on
% plot(x3,y3, 'ko');


plot(z,d2-min(d2),'r-');
 hold on
 plot(z,d1-min(d1),'b*--');
 hold on
% %plot(z,d2, '--');
% hold on
 
% %plot(z,d4, '-.');
% hold on
plot(z,d3-min(d3), 'k.--');

% [x,y] = ginput(3);
% hold on
% plot(x,y, 'o');





