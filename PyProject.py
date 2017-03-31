
# coding: utf-8

# In[56]:

import numpy as np
import time

# EuropeanCRR
def EuropeanCRR(f,p,r,delta,u,d):
    N = f.shape[0]-1
    
    for i in range(N):  # Iterate over N backwards time steps
        temp = N-i
        for j in range(temp): # Update f for a new backwards time step
            f[j] = np.exp((-r*delta)) * (p*f[j] + (1-p)*f[j+1])            
            
    return f[0]

# AmericanCRR
def AmericanCRR(f,p,r,delta,u,d,K,S0,OpType):
    N = f.shape[0]-1
    
    # OpType = 1 => Put
    
    for i in range(N):  # Iterate over N backwards time steps
        temp = N-i
        for j in range(temp): # Update f for a new backwards time step
            s = OpType * (K - S0*(d**(j))*(u**(i-j)))
            f[j] = np.max(np.exp((-r*delta)) * (p*f[j] + (1-p)*f[j+1]),s)
            
            
    return f[0]

# Binomial
def Binomial(Option,K,T,S0,sigma,r,q,N,Exercise):
    start_time = time.time()
    
    #Parameters
    delta = float(T)/float(N)
    u = np.exp(sigma*np.sqrt(delta))
    d = np.exp(-sigma*np.sqrt(delta))
    p = float(np.exp((r-q)*delta)-d)/float(u-d)   
    
    OpType = 1         # Option is a put 
    if (Option=='C'):
        OpType = -1    # Option is a call
    
    fN = np.zeros(N+1)
    
    for i in range(N+1):
        t = (OpType * (K - (u**(N-i) * d**(i) * S0)))
        fN[i] = max(0,t)
        
    if (Exercise == 'E'):
        price = EuropeanCRR(fN,p,r,delta,u,d)
    else:
        price = AmericanCRR(fN,p,r,delta,u,d,K,S0,OpType)
    
    return (price,(time.time()-start_time))
    
    
    


# In[58]:

import numpy as np

print 'Running...'

f = (np.zeros(5)+1)/2

Option = 'C'
K = 100
T = 1
S0 = 100
r = 0.05
q = 0.04
sigma = 0.2
N = 10000
Exercise = 'E'

ans = Binomial(Option,K,T,S0,sigma,r,q,N,Exercise)

print ans


# In[ ]:



