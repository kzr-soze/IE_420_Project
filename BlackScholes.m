function [ price ] = BlackScholes(Option,K,T,S0,sigma,r,q)
%BlackScholes: Determines the price of an option of type Option from the
%   inputs using the Black-Scholes-Merton formula
    
    d1 = (log(S0/K)+(r-q+1/2*sigma^2)*T)/(sigma*sqrt(T));
    d2 = d1 - sigma*sqrt(T);
    
    if (Option=='C')
        OpType = 1;
    elseif (Option=='P')
        OpType = -1;
    else
        error('Invalid option type. Use C for call and P for put.')
    end
    
    price = OpType * (S0*exp(-q*T)*normcdf(OpType*d1) - K*exp(-r*T)*normcdf(OpType*d2));


end

