function test = graph( cc, a0, a1) 

x=[-50 : 1 :300];
y=[-50 : 1 :300];
[X, Y]=meshgrid(x,y);

for i =1 : size(X)
    for j =1 : size(Y)
        val_exp=exp( -( 0.5*a0 + a1*[X(i) Y(j)]' ) );
        Z(i,j)=sum(cc .* val_exp);
    end
end
        
test=mesh(X,Y,Z);