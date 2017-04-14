clear all;
clc;

Option = 'P';
OpType = 1;
if (Option=='C')
    OpType = -1;
end
K = 100;
T = linspace(1/12,1,12);
S0 = 100;
r = 0.05;
q = 0.04;
sigma = 0.2;
Exercise = 'A';

bound = .5*10^-3; % Accuracy bound
bound2 = .5*10^-3; % Stronger bound, as in practice we're having issues
% N = zeros(12,1);
N = [2401,3201,3801,4201,4601,5001,5401,5601,6001,6201,6401,6601];
%N(12) = 12000;
step = 200;

%% Section determines the minimum values of N necessary to obtain the desired accuracy bound
% Once they are determined, they are written in and this code block does
% not need to be re-run.

% for n = 1:12
%     go = true;
%     m = step+1;
%     %[previous,comptime] = Binomial(Option,K,T(n),S0,sigma,r,q,m,Exercise);
%     while(go)
%         m = m+step;
%         [previous,comptime] = Binomial(Option,K,T(n),S0,sigma,r,q,m-1,Exercise);
%         [current,ct] = Binomial(Option,K,T(n),S0,sigma,r,q,m,Exercise);
%         disp([T(n),m,current]);
%         if (abs(previous-current) < bound2)
%             go = false;
%             N(n) = m;
%         else
%             previous = current;
%         end
%     end
% end

%% Section calculates the 12-month Put prices as a function of S0.

M = N(12);
n = 21;
up = 130;
low = 95;
S = linspace(low,up,n);
T2=.5;

price = zeros(n,1);
for k = 1:n
    [price(k),ct] = Binomial(Option,K,T2,S(k),sigma,r,q,M,Exercise);
    [temp,temp2] = Binomial(Option,K,T2,S(k),sigma,r,q,M-1,Exercise);
    disp([S(k),ct]);
    if(abs(temp-price(k)) > bound)
        disp([price(k),temp]);
        disp(['Accuracy problem for S0 = ',num2str(S(k))]);
    end
end

figure
plot(S,price);
ylabel('Price');
xlabel('S_0');
put = linspace(low,up);
y = max(0,OpType*(K-put));
hold on
plot(put,y);
    
    
    
    
    
    

