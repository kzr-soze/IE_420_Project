clear all;
close all;
clc;

Option = 'P';
OpType = 1;
OptionHeading = ' Put, ';
if (Option=='C')
    OpType = -1;
    OptionHeading = ' Call, ';
end
K = 100;
T = linspace(1/12,1,12);
S0 = 100;
r = 0.05;
q = 0.00;
sigma = 0.2;
Exercise = 'A';
ExerciseHeading = 'American ';
if (Exercise=='E')
    ExerciseHeading = 'European ';
end

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
n = 41;
up = max(155);
low = max(75);
S = linspace(low,up,n);
T2=1;

price = zeros(n,1);
for k = 1:n
    [price(k),ct] = Binomial(Option,K,T2,S(k),sigma,r,q,M,Exercise);
    %[temp,temp2] = Binomial(Option,K,T2,S(k),sigma,r,q,M-1,Exercise);
    disp([S(k),ct]);
%     if(abs(temp-price(k)) > bound)
%         disp([price(k),temp]);
%         disp(['Accuracy problem for S0 = ',num2str(S(k))]);
%     end
end

figure
plot(S,price);
ylabel('Price');
xlabel('S_0');
title([ExerciseHeading,OptionHeading,' K=',num2str(K),', T=',num2str(T2),...
    ', r=',num2str(r),', q=',num2str(q),', \sigma=',num2str(sigma)]);
put = linspace(low,up);
y = max(0,OpType*(K-put));
hold on
plot(put,y);
legend('Option Price','Early Exercise Value');
    
    
    
    
    
    

