function spread = lgm_spread_quad(model, swap1, swap2)
  %%
  %% Calculated spread option price using Gauss-Hermite quadrature
  %%
  
  npts = 8;
  [x, w] = hermite_quad(8);
  
  nfac = model.nfac;
  dim = nfac*ones(1, nfac);
  dim(1) = 1;

  K = repmat( uint8([1:npts]'), dim );
  L = repmat( uint8(0), [npts*prod(dim) nfac]);

  %% <-- need to be fixed
  
  for k = 1:nfac
    L(:, k) = K(:);
    K = shiftdim(K, 1);
  end
  clear K;
  
  weight = prod( w( L ), 2 );
  state = x( L );
  
  rate1 = lgm_swap_uncorr_state( swap1, model, state );
  rate2 = lgm_swap_uncorr_state( swap2, model, state );

  cms1 = sum( rate1.*weight );
  cms2 = sum( rate2.*weight );
  
  covar = sum( rate1.*rate2.*weight );
  var1 = sum( rate1.^2.*weight );
  var2 = sum( rate2.^2.*weight );
  corr = covar./sqrt(var1*var2);

  spread_opt = sum( max(rate1-rate2, 0).*weight );
  spread_vol;


