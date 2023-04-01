function yldcrv = yldcrv_flat_create(rate)

r_ = @(t,T) rate;
df_ = @(t,T) exp(-rate*(T-t));
yldcrv = struct('class',  'market', 'type', 'yldcrv', 'r', r_, 'df', df_);
