% test of Calibration of parameter



sig = [0.01 -0.005 -0.008];
sig_lb =[ 0 -0.01 -0.01];
sig_ub =[1 0.8 0.7];

mrv = [ 1 -0.3 -0.2];
mrv_lb = [-1 -2 -2];
mrv_ub = [3 2 2];

corr = [-0.2 -0.5 0.3];
corr_lb = [-1 -1 -1];
corr_ub = [1 1 1];
x = [sig mrv corr];

lb = [sig_lb mrv_lb corr_lb];
ub = [sig_ub mrv_ub corr_ub];

result = lsqnonlin(@minfun,x,lb,ub);