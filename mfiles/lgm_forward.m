function iv = lgm_forward(df, state, var, sigma);

iv = df .* exp(-0.5*var - sigma*state(:));
