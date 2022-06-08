---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# SEETF 2022

### UniveRSAlity <a href="#universality" id="universality"></a>

chall

```
import math, json
from secrets import token_urlsafe
from Crypto.Util.number import isPrime, bytes_to_long, long_to_bytes

def main():
    try:
        # create token
        token = token_urlsafe(8)
        js = json.dumps({'token': token})
        
        # select primes
        print(f'Welcome to the RSA testing service. Your token is "{token}".')
        print('Please give me 128-bit primes p and q:')
        p = int(input('p='))
        assert isPrime(p) and p.bit_length() == 128, 'p must be a 128-bit prime'
        assert str(float(math.pi)) in str(float(p)), 'p does not look like a certain universal constant'
        q = int(input('q='))
        assert isPrime(q) and q.bit_length() == 128, 'q must be a 128-bit prime'
        assert str(float(math.e)) in str(float(q)), 'q does not look like a certain universal constant'

        # encode
        print('We will use e=65537 because it is good practice.')
        e = 65537
        m = bytes_to_long(js.encode())
        c = pow(m, e, p * q)

        # decode
        print('Now what should the corresponding value of d be?')
        d = int(input('d='))
        m = pow(c, d, p * q)
        
        # interpret as json
        js = json.loads(long_to_bytes(m).decode())
        assert js['token'] == token, 'Invalid token!'
        print('RSA test passed!')

        if 'flag' in js:
            from secret import flag
            print(flag)
    
    except Exception as e:
        print(e)

if __name__ == '__main__':
    main()
```

solve:

generate smooth primes:

```
from pwn import *
from Crypto.Util.number import *
from sage.all import GF, crt, factor
import json

def nextPrime(x):
    x += 1
    while not isPrime(x):
        x += 1
    return x


def smoothEnough(x):
    fs = factor(x)
    return all([p < 2**40 for p, _ in fs])


def findSmooth(x):
    p = nextPrime(x)
    while not smoothEnough(p - 1):
        p = nextPrime(p)
    return p

p = findSmooth(314159265358979300000000000000000000000)
q = findSmooth(271828182845904500000000000000000000000)

print(p)
print(q)

```

fake token

```
import math, json
from secrets import token_urlsafe
from Crypto.Util.number import *

p=314159265358979300000000000000000007329
q=271828182845904500000000000000000003593
e = 65537
token = 'hexGFDdazvs'
tmp = json.dumps({'token': token})
print(tmp)
a = bytes_to_long(tmp.encode())
cipher = pow(a,e,p*q)
print(cipher)
js = json.dumps({'token':token,'flag':1})
m = bytes_to_long(js.replace(" ", "").encode())
print(m)
js = json.loads(long_to_bytes(m).decode())
print(js)
assert js['token'] == token, 'Invalid token!'
print('RSA test passed!')

if 'flag' in js:
  
    print("dkm flag đây")
```

discrete\_log - pohlig hellman

```
from Crypto.Util.number import *
p=314159265358979300000000000000000007329
q=271828182845904500000000000000000003593
n=p*q
g=45680069979954528520071734469902277992648515065786692870602025580000866427293
ct2=55695356782384679772884821853721884679606391824306327471404601387627560186237

tmp1=discrete_log(Mod(ct2,p),Mod(g,p))
tmp2=discrete_log(Mod(ct2,q),Mod(g,q))
d=crt([tmp1,tmp2],[p-1,q-1])
print(d)
```

![](<.gitbook/assets/image (19).png>)

### The True ECC <a href="#the-true-ecc" id="the-true-ecc"></a>

chall

```
// Some code
```





reference: [https://blog.maple3142.net/2022/06/06/seetf-2022-writeups/](https://blog.maple3142.net/2022/06/06/seetf-2022-writeups/)
