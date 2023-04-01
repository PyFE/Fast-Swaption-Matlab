function [fwd, level] = swap_fwd(swap, crv)
  %%
  %% Calculate fwd swap level

  level = sum(swap.coverage .* crv.df(0, swap.schedule)); % npv of fixed coupon 1
  %level = sum(swap.coverage .* crv.df(swap.start, swap.schedule)); % npv of fixed coupon 1
  
  fwd = (crv.df(0, swap.start) - crv.df(0, swap.end))/level;
  
  
  
end
  
  
