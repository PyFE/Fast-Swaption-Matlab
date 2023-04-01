function price = lgm_swaption(swaption, model, options)

t = swaption.expiry;
Tk = swaption.swap._schedule;
strike = swaption.strike;
cvg = swaption.swap._coverage;

output = process_options(options, "output", "price");

%%%% construct discounted cashflow of payer swaption
fwd_df = model.df( t, Tk );
cf = -strike * cvg;
cf(1) = 1;
cf(end) = cf(end) - 1;
cf = fwd_df .* cf;
fwd = sum(cf);

%%%% extract var and sigma
riskprem = lgm_getriskprem(model, t, Tk);
covar = lgm_getcovar(model, t);
stdev = sqrt( diag(covar) );
corr = covar./(stdev*stdev');

sigma = riskprem * chol(covar)';
var = sum(sigma.^2, 2);

%%%% Newton
[x0, gradn0] = lgm_findmindistzero( cf, var, sigma );

%%%% always price call and convert to other types
call = sum(cf .* normcd f(-(sigma + ones(size(var))*x0)*gradn0'));

[fwd, level] = swap_fwd(swaption.swap);

price = cnvt_prem(typeOut, 'call', call/level, strike, fwd, t);
