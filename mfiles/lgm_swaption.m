
%function [price,x0,gradn0,cf,var,sigma]  = lgm_swaption(swaption, model, crv, varargin)

function [price, exac, error] = lgm_swaption(swaption, model, crv, varargin)

% function price = lgm_swaption(swaption, model, crv, varargin)

t = swaption.expiry;
Tk = swaption.swap.schedule;
strike = swaption.strike;
cvg = swaption.swap.coverage;

output = process_options(varargin, 'output', 'price');

%%%% construct discounted cashflow of payer swaption
df = crv.df( 0, Tk );
cf = -strike * cvg;         % fixed leg
cf(1) = 1;                  % floating leg     ó���� 1�� ������ ���⿡ 1�� ���� �� 
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


%grh = lgm_exercise_boundary(gradn0,cf,var,sigma)

%test = int_diff_figure(x0, gradn0, cf, var, sigma);

%%%% always price call and convert to other types
call = sum(cf .* normcdf(-(sigma + ones(size(var))*x0)*gradn0'));
price=call;

 exac = exac_method(x0, gradn0, cf, var, sigma);
% 
 error = price - exac;

[fwd, level] = swap_fwd(swaption.swap, crv);

if( strcmpi( output, 'vol' ) )
	price = cnvt_prem( 'norm', 'call', call/level, strike, fwd, t) * 10000/sqrt(252);    
 	exac = cnvt_prem( 'norm', 'call', exac/level, strike, fwd, t) * 10000/sqrt(252);
    error = price - exac ;
end

if( strcmpi( output, 'Blvol' ) )
	price = impBLvol('Newton',call/level, fwd,strike,0,t);
end
if(strcmpi(output, 'figure'))
    price = int_boundary(gradn0, cf, var, sigma);
end