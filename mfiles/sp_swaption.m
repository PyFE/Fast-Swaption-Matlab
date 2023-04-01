
function price = sp_swaption(swaption, model, crv, varargin)

% price of swaption using SP method(using annuity measure)

Tk = swaption.swap.schedule;
strike = swaption.strike;
cvg = swaption.swap.coverage;

output = process_options(varargin, 'output', 'price');

% annuity measure & swap measure
%T0=Tk(1), 일단 business day 무시

T0=Tk(1);
zerobond = crv.df(0,Tk);           %zero-coupon bond at time 0
annuity = sum(zerobond.*cvg);       % A(0)
zswap = (crv.df(0,T0) -crv.df(0,Tk(end)))/annuity;   % S(0):value of swap rate at zero

% coefficient of swap rate(q)
coeff = -zerobond.*cvg*zswap/annuity;
coeff(1) = zerobond(1)/annuity;
coeff(end) = coeff(end) - zerobond(end)/annuity;


df = sp_discount(model,Tk);

C=zeros(1,model.nfac);
vol=zeros(1,model.nfac);
mrv=zeros(1,model.nfac);

% C = constant part of swap rate    p692(SP paper)
for k =1 : model.nfac
    C(k) = sum(coeff.*df(:,k));
    vol(k) = model.vol(1)*model.volratio(k);
    mrv(k) = model.mrv(1)+model.mrvspread(k);
end

sigma = sp_sigma(model.nfac,C,vol,mrv,model.corr,T0);

d = (zswap-strike)/sigma;

price = annuity*((zswap-strike)*normcdf(d) + sigma*normpdf(d));


[fwd, level] = swap_fwd(swaption.swap, crv);   %A(0)=level, fwd=zswap

call = price;
if( strcmpi( output, 'vol' ) )
	price = cnvt_prem( 'norm', 'call', call/level, strike, fwd, T0) * 10000/sqrt(252);    
	
end

if( strcmpi( output, 'Blvol' ) )
	price = impBLvol('Bisection',call/level, zswap,strike,0,T0);
end


end