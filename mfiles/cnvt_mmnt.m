function mmntOut = cnvt_mmnt(typeOut, typeIn, mmntIn, varargin)
%
% mmntOut = cnvt_mmnt(typeOut, typeIn, mmntIn, varargin)

center = process_options(varargin, 'CENTER', 0);

sizOut = size(mmntIn);
mmntIn = mmntIn(:);
nOrder = length(mmntIn);

mmnt = zeros(size(mmntIn));
mmntOut = zeros(size(mmntIn));

if strcmpi(typeIn, typeOut)
    
    mmntOut = mmntIn;
    return;
    
end

if any(strcmpi(typeIn, {'c', 'cum', 'cmnt', 'cumulant', 'cumulants'}))
    
    T = sym('__T__');
    
    MGF = taylor( exp(T.^[1:nOrder]./cumprod(1:nOrder)*mmntIn), nOrder+1);

    for k = 1:nOrder
        MGF = diff( MGF, T );
        mmnt(k) = subs(MGF, T, 0);
    end
else

    mmnt = mmntIn;
    
end

if any(strcmpi(typeOut, {'m', 'mom', 'mmnt', 'moments'}))

    for k = 1:nOrder;
        mmntOut(k) = ...
            sum( binocoef(k).*(-center).^[0:k]'.*[mmnt(k:-1:1); 1] );
    end
    
elseif any(strcmpi(typeOut, {'c', 'cum', 'cumulant', 'cumulants'}))
    
    T = sym('__T__');

    logMGF = taylor( log(1 + T.^[1:nOrder]./cumprod(1:nOrder)*mmnt), ...
                     nOrder+1 );
    
    for k = 1:nOrder
        logMGF = diff( logMGF, T );
        mmntOut(k) = subs(logMGF, T, 0);
    end
    
else
    
    error('Invalid MmntOut type: %s', typeOut);
    
end

mmntOut = reshape(mmntOut, sizOut);
