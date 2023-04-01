

vol_ts = [0 0.01; 5 0.01; 20 0.01];
mrv_ts = [0 1.0; 10 1.0];
volratio = [0.5 0.2];
mrvspread = [-0.8 -0.5];
crv = yldcrv_flat_create(0.055);
corr = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];


K=0.042 : 0.001 : 0.07;


for i = 1 : length(K)
    swaption = swaption_create(K(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
    model3 = lgm_create(3, vol_ts, mrv_ts, volratio, mrvspread, corr);
    [vol, vol_exac, error] = lgm_swaption(swaption, model3, crv, 'output', 'vol');
    abs_error(i)=error;
   
    
    
end

X=plot(K, abs_error, 'r*-');
grid on;

    