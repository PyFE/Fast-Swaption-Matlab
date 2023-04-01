function ...
res = comp_premtype(type1, type2, varargin)

AAA = { ...
    {'CALL', 'c', 'rec'}; 
    {'PUT' , 'p', 'pay'}; 
    {'STRD', 's', 'straddle'}; 
    {'DIG' , 'd'}; 
    {'NORM', 'n', 'normal', 'gaussian'}; 
    {'BLKS', 'b', 'bs', 'black', 'log', 'lognormal'}; 
    {'SIG' , 'sigma', 'cev', 'beta', 'sabr', 'hstn', 'hstnnorm'}; 
      };

res = logical(0);

for k = 1:size(AAA, 1)

    if( any(strcmpi(type1, AAA{k})) && any(strcmpi(type2, AAA{k})) )
        res = logical(1);
        return
    end
end
