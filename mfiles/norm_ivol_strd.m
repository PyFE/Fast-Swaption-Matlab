function volNorm = ...
    norm_ivol_strd(strd, strk, fwd, T)

%  Calculates implied volatility of normal model for a given straddle price.
%
% volNorm = norm_implv_strd(strd, strk, fwd, T)

global DEBUG_


zeroSiz = zeros(size(strd + strk + fwd));

fwd  = fwd + zeroSiz;
strk = strk + zeroSiz;
strd = strd + zeroSiz;

maxIter = 32;
maxTor = 100*eps;
volNorm = repmat(nan,size(strd));

valueOption = strd - abs(fwd-strk);

for k = 1:length(strd)
    
    % boundary check for strd
    if ( valueOption(k) < 0 )
        warning('Straddle price should be higher than intrinsic value.')
        %continue;
        break;
    elseif ( valueOption(k) < maxTor )
        warning('Option value is too small. volNorm set to 0.0');
        volNorm(k) = 0;
        %continue;        % 이 부분 질문 필요
    end
        
    volGuess0 = sqrt(pi/2/T)*strd(k);
    volGuess = volGuess0;
    
    for kIter = 1:maxIter

        [strdGuess, vega, volga] = ...
            norm_strd_vega(strk(k), fwd(k), T, volGuess);

        strdError = strdGuess - strd(k);
        
        if DEBUG_
            sprintf('  volGuess: %0.4f, strdError: %0.2e, vega: %0.2e', ...
                    volGuess, strdError, vega)
        end
        
        if ( abs(strdError) < maxTor) 
            break; 
        elseif (strdError < 0)
            volGuess = volGuess + 0.05*volGuessStep; % step back 5% of
                                                     % previous increcment
        else
            %%%% 1st order
            volGuess = volGuess - strdError/vega;
            volGuessStep = strdError/vega;
            %%%% 2nd order
            %volGuess = volGuess - 2*strdError/(vega+sqrt(vega^2-2*volga*strdError));
        end

    end

    if DEBUG_    % debuf info
        sprintf([ '%02d: strd: %0.3f, strk: %0.3f, fwd: %0.3f \n' ...
                  '  volNorm: %0.3f [Start: %0.3f] \n' ...
                  '  nIter: %d, strdError: %0.2e \n' ...
                  '--------------------------------------------------------------\n' ...
                ], k, ...
                strd(k), strk(k), fwd(k), volGuess, ...
                volGuess0, kIter, strdError)
    end
    
    if (kIter<maxIter)
        volNorm(k) = volGuess;
    else
        warning(message('%02d: Newton method failed within %d iterations for strd %f, error: %e', k, kIter, strd(k), strdError));
    end
end
