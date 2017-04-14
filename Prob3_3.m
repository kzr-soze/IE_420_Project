% Generates the critical exercise price for an American option with the
% given parameters as a function of time to maturity.

clear all;
clc;

Option = 'C';
OpType = 1;
if (Option=='C')
    OpType = -1;
end
K = 100;
I = 12;
T = (0:I)/I;
S0 = 100;
r = 0.05;
q = 0.04;
sigma = 0.2;
Exercise = 'A';

if (OpType == 1)
    ub = K;
    lb = .5*K;
else
    ub = 1.5*K;
    lb = K;
end

N = 7200;
bound = 5*10^-4;

price = zeros(I+1,1);
S = zeros(I+1,1);
%disp(T)
for j=1:(I+1)
    disp(T(j));
    [price(j),S(j)] = ExerciseBoundary(Option,K,T(j),sigma,r,q,N,Exercise,ub,lb);
end

plot(T*12,S);
xlabel('Time to Maturity (months)');
ylabel(['Critical Exercise Price (',Option,')']);
title('K = 100');

% while (go)
%     S = (ub+lb)/2;
%     count = count+1;
%     [price,ct] = Binomial(Option,K,T,S,sigma,r,q,N,Exercise);
%     disp([S,ct]);
%     %[exer,index] = ExerciseAt(Option,S,K,price);
%     % disp(['Cycle: ',num2str(count),' Candidate Solution: ',num2str(S)]);
%     
%     if( abs((OpType*(K-S) - price)) < bound)
%         go = false;
%     elseif ( OpType*(K-S) > price)
%         lb = S;
%         S = (ub+lb)/2;
%     else
%         ub = S;
%         S = (ub+lb)/2;
%     end
% end
    
    
    
    

