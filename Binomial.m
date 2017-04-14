function [ price,t ] = Binomial(Option,K,T,S0,sigma,r,q,N,Exercise)
%Binomial: Prices an option according to the binomial model with the given
%parameters.

    % Start timer
    tic

    delta = T/N;
    u = double(exp(sigma*delta^.5));
    d = 1/u;
    p = double((exp((r-q)*delta)-d)/(u-d));
    
    
    %disp(delta);
    %disp(u);
    %disp(d);
    %disp(p);
    
    OpType = 1;         % Option is a Put
    if (Option=='C')
        OpType = -1;    % Option is a Call
    end
    
    sN = double(zeros(N+1,1));  % Possible values of the option at time T
    
    for i = 1:N+1       % Initialize fN
        t = OpType*(K-(u^(N+1-i)*d^(i-1)*double(S0)));
        sN(i) = t;
    end
    %disp(sN');
    fN = max(0,sN);
    
    %disp(Exercise);
    if (Exercise=='E')
        price = double(EuropeanCRR(q,r,delta,sigma,N,K,S0,OpType));
    else
        %disp('American');
        price = double(AmericanCRR(q,r,delta,sigma,N,K,S0,OpType));
    end
    
    t = toc;


end

