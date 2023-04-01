function F =minfun(x)

marketData = xlsread('marketVol');

F = zeros(size(marketData,1),1);

for i = 1 : length(F)
   
    F(i) = (marketData(i,3)-modelSwaption(x,marketData(i,1),marketData(i,2)))/marketData(i,3);
end

end

    
    

