function [ price] = AmericanCRR(q,r,delta,sigma,N,K,S0,OpType)
%AmericanCRR: Uses backwards induction to calculate the price of an American
%   asset (put or call) at time 0.
    

    u = exp(double(sigma*sqrt(delta)));
    d = 1/u;
    p = (double(exp((r-q)*delta)-d))/(u-d);
    f = zeros(N+1,1);
    S = zeros(N+1,1);
    S(1)=S0;
    %disp(u);
    %disp(p);
    for j = 2:N+1 % The double loop is necessary because of rounding issues that compound
                  % when u and d have high exponents
        S(j) = d*S(j-1);
        for i = j-1:-1:1
            S(i) = double(u*S(i));
        end
    end
    %disp(S);
    
    if (OpType == 1)
        f = max(K-double(S),0);
    else
        f = max(double(S)-K,0);
    end
    g = f';
    gs = S';
    %disp(f');
    for j = N+1:-1:1
        S = double(S)/u;
        for i = 1:j-1
            f(i) = double(exp(-(r)*delta)*(p*f(i) + (1-p)*f(i+1)));
        end
        if (OpType == 1)
            for i = 1:j-1
                f(i) = max(f(i),double(K-S(i)));
            end
        else 
            for i = 1:j-1
                f(i) = max(f(i),double(S(i)-K));
            end 
        end
        %g = [g;f'];
        %gs = [gs;S'];
    
    end
    %disp(gs');
    %disp(g');
    price = double(f(1));
    
    
    
    
    
end

