function df = sp_discount(model,T)


mrv=model.mrv(1);   % 벡터를 상수로...

df = zeros(length(T),model.nfac);

for i=1:model.nfac
    df(:,i) = exp(-(mrv+model.mrvspread(i))*T)/(mrv+model.mrvspread(i));
end

