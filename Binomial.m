function [ price,t ] = Binomial(Option,K,T,S0,sigma,r,q,N,Exercise)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % Start timer
    tic

    delta = T/N;
    u = exp(sigma*sqrt(delta));
    d = exp(-sigma*sqrt(delta));
    p = (exp((r-q)*delta)-d)/(u-d);
    OpType = 1;         % Option is a Put
    if (Option=='C')
        OpType = -1;    % Option is a Call
    end
    
    fN = zeros(N+1,1);  % Possible values of the option at time T
    
    for i = 1:N+1       % Initialize fN
        t = OpType*(K-(u^(N+1-i)*d^(i-1)*S0));
        fN(i) = max(0,t);
    end
    
    if (Exercise=='E')
        price = EuropeanCRR(fN,p,r,delta,u,d);
    else
        price = AmericanCRR(fN,p,r,delta,K,S0,u,d,OpType);
    end
    
    t = toc;


end

