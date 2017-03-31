function [ price ] = AmericanCRR(f,p,r,delta,K,S0,u,d,OpType)
%AmericanCRR: Uses backwards induction to calculate the price of an American
%   asset (put or call) at time 0.
    
    N = size(f,1)-1;
    
    % OptType = 1 => Put
    
    for i = N:-1:1  % Iterate over N backwards time steps
        for j = 1:i % Update f for a new backwards time step
            s = OpType*(K-S0*d^(j-1)*u^(i-j+1));
            f(j) = max(exp(-r*delta)*(p*f(j) + (1-p)*f(j+1)),s);
        end
    end
    
    price = f(1);
    


end

