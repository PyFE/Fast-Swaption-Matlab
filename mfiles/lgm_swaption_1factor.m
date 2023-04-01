
%function [price,x0,gradn0,cf,var,sigma]  = lgm_swaption(swaption, model, crv, varargin)

function [price, exac, error] = lgm_swaption_1factor(swaption, model, crv, varargin)

%function exac = lgm_swaption(swaption, model, crv, varargin)

t = swaption.expiry;
Tk = swaption.swap.schedule;
strike = swaption.strike;
cvg = swaption.swap.coverage;

output = process_options(varargin, 'output', 'price');

%%%% construct discounted cashflow of payer swaption
df = crv.df( 0, Tk );
cf = -strike * cvg;         % fixed leg
cf(1) = 1;                  % floating leg     처음에 1을 빌려서 만기에 1을 갚는 것 
cf(end) = cf(end) - 1;
cf = df .* cf;
%fwd = sum(cf);

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
call = sum(cf .* normcdf(-(sigma + ones(size(var))*x0)*gradn0'));
price=call;



[fwd, level] = swap_fwd(swaption.swap, crv);

if( strcmpi( output, 'vol' ) )
	price = cnvt_prem( 'norm', 'call', call/level, strike, fwd, t) * 10000/sqrt(252);    
end

if( strcmpi( output, 'Blvol' ) )
	price = impBLvol('Newton',call/level, fwd,strike,0,t);
end
