
# coding: utf-8

# In[25]:

def sieveOfEratosthenes(n):
    """sieveOfEratosthenes(n): return the list of the primes < n."""
    # Code from: <dickinsm@gmail.com>, Nov 30 2006
    # http://groups.google.com/group/comp.lang.python/msg/f1f10ced88c68c2d
    if n <= 2:
        return []
    sieve = list(range(3, n, 2)) #Starting from 3 to n taking odds numbers
    top = len(sieve) 
    
    for si in sieve:
        if si:                        # is not 0
            bottom = (si*si - 3) // 2  # starting from si^2
            if bottom >= top:
                break    
            sieve[bottom::si] = [0] * - ((bottom - top) // si) #mark all si*n (n>si)
            
    return [2] + [el for el in sieve if el]


# In[26]:

print (sieveOfEratosthenes(1000))

