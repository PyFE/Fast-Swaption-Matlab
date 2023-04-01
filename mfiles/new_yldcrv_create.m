function yldcrv = new_yldcrv_create()

r_ = @(t,T) rate;  % discount factor from 0% to 6%
df_ = @(t,T) exp( -0.01 * ( 6*(T-t) + 60*exp(-(T-t)/10) - 60 ) );

%df_ = @(t,T) exp( -0.01 * ( 8*(T-t) + 50*exp(-(T-t)/10) - 50 ) );
  

yldcrv = struct('class',  'market', 'type', 'yldcrv', 'r', r_, 'df', df_);


