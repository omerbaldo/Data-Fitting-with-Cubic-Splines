function FitCubSpline(K)

data = feval('load', 'SAheart.data');
data = data(:,[2:5 7:10]);
s = randsample(8,2);
x = data(:,s(1)); 
y = data(:,s(2)); 

names = {'sbp','tobacco','ldl','adiposity','famhist','obesity','alcohol','age'};

figure;
plot(x,y,'o');hold on; grid on;
set(gca,'fontsize',20,'xlim',[min(x)-1 max(x)+1]);
xlabel(names(s(1)));ylabel(names(s(2)));

h = (max(x)-min(x))/(K+1);
for i = 1:K
    Z(:,i) =  max(x-h*i,0);
end
X = [ones(length(x),1) x x.^2 x.^3 Z.^3];
be = (X'*X)\(X'*y);

x0 = min(x):0.1:max(x);x0 = x0';
for i = 1:K
    Z0(:,i) =  max(x0-h*i,0);
end
X0 = [ones(length(x0),1) x0 x0.^2 x0.^3 Z0.^3];
Y0 = X0*be;

plot(x0,Y0,'r-','linewidth',2);

for i = 1:K
    plot(min(x)+[h h]*i,[min(y),max(y)],'b--','linewidth',2);
end


