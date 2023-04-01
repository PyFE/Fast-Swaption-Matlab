
for i=1 : 100

tic

vol_ts = [0 0.02; 0.25 0.014; 0.5 0.013; 1 0.012; 2 0.01; 5 0.009];
mrv_ts = [0 -0.051; 5 0.059; 10 0.017 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;
    
crv = yldcrv_flat_create(0.05);
model2 = lgm_create(2, vol_ts, mrv_ts, volratio, mrvspread, corr);

% K=0.01 : 0.11./50 : 0.12;
% 
% for i = 1 : length(K)
%     swaption = swaption_create(K(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
%     price(i) = lgm_swaption(swaption, model2, crv);
% end
% 

swaption = swaption_create(0.0506, 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
price = lgm_swaption(swaption, model2, crv);
toc;

end