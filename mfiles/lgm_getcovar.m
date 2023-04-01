function covar = lgm_getcovar(model, t)

nfac = model.nfac;

covar = zeros(nfac);

for k1 = 1:nfac

  for k2 = 1:k1
    lam = pwc_int(model.time, 2*model.mrv+model.mrvspread(k1)+model.mrvspread(k2), 0, t);

    zeta = pwc_int_exp_int(model.time, model.corr(k1, k2)*prod(model.volratio([k1 k2]))*model.vol.^2, ...
        2*model.mrv + model.mrvspread(k1) + model.mrvspread(k2), 0, 0, t);

    %covar(k1, k2) = exp(-2*lam) * zeta;
    covar(k1, k2) = exp(-lam) * zeta;
    covar(k2, k1) = covar(k1, k2);
  end

end
