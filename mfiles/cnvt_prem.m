function premOut = cnvt_prem(typeOut, typeIn, premIn, strk, fwd, T, varargin)
%
% premOut = cnvt_prem(typeOut, typeIn, premIn, strk, fwd, T, varargin)


% typeIn == typrOut
if comp_premtype(typeOut, typeIn)

    premOut = premIn;
    return;
    
end

% premIn -> call
if comp_premtype(typeIn, 'call')
    
    call = premIn;
    put  = call - (fwd-strk);
    
elseif comp_premtype(typeIn, 'put')
    
    call = premIn + (fwd-strk)
    put  = premIn;
    
elseif comp_premtype(typeIn, 'strd')
    
    call = 0.5*(premIn + (fwd-strk));
    put  = premIn - call;
    
elseif comp_premtype(typeIn, 'blks')

    call = blks_call(strk, fwd, T, premIn);
    put  = call - (fwd-strk);
    
elseif comp_premtype(typeIn, 'norm')

    call = norm_call(strk, fwd, T, premIn);
    put  = call - (fwd-strk);
    
end


% call -> premOut
if comp_premtype(typeOut, 'call')

    premOut = call;

elseif comp_premtype(typeOut, 'put')

    premOut = put;

elseif comp_premtype(typeOut, 'strd')

    premOut = strd;

elseif comp_premtype(typeOut, 'blks')

    premOut = blks_ivol_strd(call+put, strk, fwd, T);

elseif comp_premtype(typeOut, 'norm')

    premOut = norm_ivol_strd(call+put, strk, fwd, T);
    
end
