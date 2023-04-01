function rate = lgm_swap_uncorr_state( swap, model, state )
  %%
  %% Calculates swap rates given uncorrelated sates
  %%
  %% state: [x1 x2 x3; ...]
  
  t = swap.schedule(1);
  Tk = swap.schedule;
  cvg = swap.coverage;

  %%%% extract var and sigma
  riskprem = lgm_getriskprem(model, t, Tk);
  covar = lgm_getcovar(model, t);
  stdev = sqrt( diag(covar) );
  corr = covar./(stdev*stdev');
  
  sigma = riskprem * chol(covar)';
  var = sum(sigma.^2, 2);
  
  %% col: Tk, row: state
  df_all = (model.df(t, Tk).*exp(-var/2))*ones(1,size(state,1)).*exp(-sigma*state');
  
  rate = [ ( df_all(1,:)-df_all(end,:) )./(cvg'*df_all) ]';


