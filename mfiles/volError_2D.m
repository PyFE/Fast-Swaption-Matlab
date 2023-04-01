% Example 1

vol_ts1 = [0 0.03; 0.25 0.024; 0.5 0.024; 1 0.022; 2 0.018; 5 0.012];
mrv_ts1 = [0 0.115; 5 0.073; 10 0.029 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;
crv1 = yldcrv_flat_create(0.05);



% Example 2
vol_ts2 = [0 0.02; 0.25 0.014; 0.5 0.013; 1 0.012; 2 0.01; 5 0.009];
mrv_ts2 = [0 -0.051; 5 0.059; 10 0.017 ];
volratio = 1.05;
mrvspread = 0.27;
corr = -0.77;
crv2 = new_yldcrv_create();

% Example 3
vol_ts3 = [0 0.01; 5 0.01; 20 0.01];
mrv_ts3 = [0 1.0; 10 1.0];

crv3 = yldcrv_flat_create(0.055);
cor3 = [1 -0.2 -0.1; -0.2 1 0.3; -0.1 0.3 1];


K=0.042 : 0.001 : 0.07;



for i = 1 : length(K)
    swaption1 = swaption_create(K(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
    model1 = lgm_create(2, vol_ts1, mrv_ts1, volratio, mrvspread, corr);
    [vol, vol_exac, error] = lgm_swaption(swaption1, model1, crv1, 'output', 'vol');
    Error1(i)=error;
    
    swaption2 = swaption_create(K(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
    model2 = lgm_create(2, vol_ts2, mrv_ts2, volratio, mrvspread, corr);
    [vol, vol_exac, error] = lgm_swaption(swaption2, model2, crv2, 'output', 'vol');
    Error2(i)=error;
    
    swaption3 = swaption_create(K(i), 'rec', 1.99, 2, 10, 0.5, 'bb', 3);
    model3 = lgm_create(3, vol_ts3, mrv_ts3, [0.5 0.2], [-0.8 -0.5], cor3);
    [vol, vol_exac, error] = lgm_swaption(swaption3, model3, crv3, 'output', 'vol');
    Error3(i)=error;
end



K=K.*100;
plot(K, Error1, 'r-');
hold on;
plot(K, Error2, 'b*-');
hold on
plot(K, Error3, 'k-.');



