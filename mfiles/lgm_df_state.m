function df = lgm_df_state( t, T, model, state )

  df0 = model.df( t, T );
  
  riskprem = lgm_getriskprem(model, t, T);
  covar = lgm_getcovar(model, t);
  
  iv = df .* exp(-0.5*var - sigma*state(:));
  
