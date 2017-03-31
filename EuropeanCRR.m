function [ price ] = EuropeanCRR(f,p,r,delta,u,d)
%EuropeanCRR: Uses backwards induction to calculate the price of a European
%   asset (put or call) at time 0.
    
    N = size(f,1)-1;
    
    
    for i = N:-1:1  % Iterate over N backwards time steps
        for j = 1:i % Update f for a new backwards time step
            f(j) = exp(-r*delta)*(p*f(j) + (1-p)*f(j+1));
        end
 
    end
    price = f(1);
    


end

