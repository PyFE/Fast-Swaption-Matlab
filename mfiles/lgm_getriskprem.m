function riskprem = lgm_getriskprem(model, t, T)
%
% t: scalar
% T: column vector

T = T(:);
riskprem = zeros( length(T), model.nfac );

for k = 1 : model.nfac
  riskprem(:, k) = pwc_int_exp_int(model.time, [],...  
  -(model.mrv+model.mrvspread(k)), t, t, T);
end
