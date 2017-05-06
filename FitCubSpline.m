function FitCubSpline(K)
    data = feval('load', 'SAheart.data');
    data = data(:,[2:5 7:10]);
    s = randsample(8,2);
    x = data(:,s(1)); %select column at s(1)
    y = data(:,s(2)); %s(2) is column number. returns column at this
    names = {'sbp','tobacco','ldl','adiposity','famhist','obesity','alcohol','age'};
    figure;
    scatter(x,y);hold on; grid on;  % sin(5x)
    xlabel(names(s(1)));ylabel(names(s(2)));
    %{
        k is sections
    
            make k + 1 sections
     
    %}
    
    minx = min(x);
    maxx = max(x);
    miny = min(y);
    maxy = max(y);
    
    step = (maxx-minx)/(K+1);
    c = zeros(1,K);
    for i = 1:K
        xlocation = minx + (i*step);
        c(1,i) = xlocation;
        line([xlocation xlocation],[miny maxy],'Color','b','LineStyle','--');       
    end

    X = zeros(length(x),4+K);
    
    % fill in X
    for i=1:length(x)
        for j=1:4
            X(i,j) = x(i,1).^(j-1);
        end
        for j=1:K
            X(i,4+j) = (x(i,1)-c(1,j)).^3;
          
            if X(i,4+j)<=0
                 X(i,4+j) = 0;
            end
     
        end
    end
    
    xTranspose = X.'; 
    beta = (xTranspose * y)\(xTranspose * X);
    beta = beta.';
    
    fx = zeros(length(x),1);
    for i =1: length(x)
        for j = 1: length(beta)
            if j<5
                fx(i,1) = fx(i,1) + beta(j,1)*(x(i,1).^(j-1));
            else
                fx(i,1) = fx(i,1) + beta(j,1)*((x(i,1)-c(1,j-4)).^(3));
            end
        end
    end 
    
    plot(x,fx.','r--','linewidth',2);hold on; grid on;  % sin(5x)

    disp('end');
end
    
    
