clear all;
clc;

Option = 'C';
K = 100;
T = 1;
S0 = 100;
r = 0.05;
q = 0.04;
sigma = 0.2;
Exercise = 'E';


NMax = 10;
interval = 1;

priceBSM = BlackScholes(Option,K,T,S0,sigma,r,q);
priceBNM = zeros(floor(NMax/interval),1);
CompTime = zeros(floor(NMax/interval),1);
Nvals = zeros(floor(NMax/interval),1);

for i = 1:floor(NMax/interval)
    [priceBNM(i,1),CompTime(i,1)] = Binomial(Option,K,T,S0,...
        sigma,r,q,i*interval,Exercise);
    Nvals(i,1) = interval*i;
    disp(interval*i);
    
end

error = 100*(priceBNM - priceBSM)/priceBSM;

figure;
plot(Nvals,error,'b');
xlabel('N time steps');
ylabel('Error (%)');

figure;
plot(Nvals,CompTime,'r');
xlabel('N time steps');
ylabel('Computation Time (sec)');
    
    