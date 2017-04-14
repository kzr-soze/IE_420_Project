function [ price] = EuropeanCRR(q,r,delta,sigma,N,K,S0,OpType)
%EuropeanCRR: Uses backwards induction to calculate the price of an American
%   asset (put or call) at time 0.
    

    u = exp(sigma*sqrt(delta));
    d = 1/u;
    p = (exp((r-q)*delta)-d)/(u-d);
    f = zeros(N+1,1);
    S = zeros(N+1,1);
    S(1)=S0;
    %disp(u);
    %disp(p);
    for j = 2:N+1 % The double loop is necessary because of rounding issues that compound
                  % when u and d have high exponents
        S(j) = d*S(j-1);
        for i = j-1:-1:1
            S(i) = u*S(i);
        end
    end
    %disp(S');
    
    if (OpType == 1)
        f = max(K-S,0);
    else
        f = max(S-K,0);
    end
    % disp(f');
    for j = N+1:-1:1
        S = S/u;
        for i = 1:j-1
            f(i) = exp(-(r)*delta)*(p*f(i) + (1-p)*f(i+1));
        end
        % disp(f');
    end
    price = f(1);
end

