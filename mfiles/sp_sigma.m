function sigma=sp_sigma(n,c,v,m,corr,T)

% c : constant part of swap rate
% v : volatiltiy vector
% m : mean reversion vector

sigma = zeros(n);

for i=1: n
    for j=1:n
        sigma(i,j) = corr(i,j)*v(i)*v(j)*c(i)*c(j)*(exp((m(i)+m(j))*T)-1)/(m(i)+m(j));
    end
end

sigma = sqrt(sum(sum(sigma)));
    


end