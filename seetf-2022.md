---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# SEETF 2022

Nay lười viết quá để script thôi : D

![](<.gitbook/assets/image (14) (1) (1).png>)

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

![](<.gitbook/assets/image (19) (1).png>)

### The True ECC <a href="#the-true-ecc" id="the-true-ecc"></a>

chall

```
# python ecc.py > out.py

from random import randint
from os import urandom
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from hashlib import sha1

from typing import Tuple


class Ellipse:

    """Represents the curve x^2 + ay^2 = 1 mod p"""

    def __init__(self, a: int, p: int):

        self.a = a
        self.p = p

    def __repr__(self) -> str:
        return f"x^2 + {self.a}y^2 = 1 mod {self.p}"

    def __eq__(self, other: 'Ellipse') -> bool:
        return self.a == other.a and self.p == other.p

    def is_on_curve(self, pt: 'Point') -> bool:

        x, y = pt.x, pt.y
        a, p = self.a, self.p
        return (x*x + a * y*y) % p == 1


class Point:

    """Represents a point on curve"""

    def __init__(self, curve: Ellipse, x: int, y: int):

        self.x = x
        self.y = y
        self.curve = curve
        assert self.curve.is_on_curve(self)

    def __repr__(self) -> str:
        return f"({self.x}, {self.y})"

    def __add__(self, other: 'Point') -> 'Point':

        x, y = self.x, self.y
        w, z = other.x, other.y
        a, p = self.curve.a, self.curve.p

        nx = (x*w - a*y*z) % p
        ny = (x*z + y*w) % p
        return Point(self.curve, nx, ny)

    def __mul__(self, n: int) -> 'Point':

        assert n > 0

        Q = Point(self.curve, 1, 0)
        while n > 0:
            if n & 1 == 1:
                Q += self
            self += self
            n = n//2
        return Q

    def __eq__(self, other: 'Point') -> bool:
        return self.x == other.x and self.y == other.y


def gen_secret(G: Point) -> Tuple[Point, int]:

    priv = randint(1, p)
    pub = G*priv
    return pub, priv


def encrypt(shared: Point, pt: bytes) -> bytes:

    key = sha1(str(shared).encode()).digest()[:16]
    iv = urandom(16)
    cipher = AES.new(key, AES.MODE_CBC, iv)
    ct = cipher.encrypt(pad(pt, 16))
    return iv + ct


def decrypt(shared: Point, ct: bytes) -> bytes:

    iv, ct = ct[:16], ct[16:]
    key = sha1(str(shared).encode()).digest()[:16]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    pt = cipher.decrypt(ct)
    return unpad(pt, 16)


a, p = 376014, (1 << 521) - 1
curve = Ellipse(a, p)

gx = 0x1bcfc82fca1e29598bd932fc4b8c573265e055795ba7d68ca3985a78bb57237b9ca042ab545a66b352655a10b4f60785ba308b060d9b7df2a651ca94eeb63b86fdb
gy = 0xca00d73e3d1570e6c63b506520c4fcc0151130a7f655b0d15ae3227423f304e1f7ffa73198f306d67a24c142b23f72adac5f166da5df68b669bbfda9fb4ef15f8e
G = Point(curve, gx, gy)

if __name__ == "__main__":

    from flag import flag

    alice_pub, alice_priv = gen_secret(G)
    blake_pub, blake_priv = gen_secret(G)

    shared = alice_pub * blake_priv
    ct = encrypt(shared, flag)

    assert shared == blake_pub * alice_priv
    assert decrypt(shared, ct) == flag

    print("alice_pub =", alice_pub)
    print("blake_pub =", blake_pub)
    print("ct =", ct)
    
alice_pub = (2138196312148079184382240325330500803425686967483863166176111074666553873369606997586883533252879522314508512610120185663459330505669976143538280185135503158, 1350098408534349199229781714086607605984656432458083815306756044307591092126215092360795039519565477039721903019874871683998662788499599535946383133093677646)
blake_pub = (4568773897927114993549462717422746966489956811871132275386853917467440322628373530720948282919382453518184702625364310911519327021756484938266990998628406420, 3649097172525610846241260554130988388479998230434661435854337888813320693155483292808012277418005770847521067027991154263171652473498536483631820529350606213)
ct = b'q\xfa\xf2\xe5\xe3\xba.H\xa5\x07az\xc0;\xc4%\xdf\xfe\xa0MI>o8\x96M\xb0\xfe]\xb2\xfdi\x8e\x9e\xea\x9f\xca\x98\xf9\x95\xe6&\x1fB\xd5\x0b\xf2\xeb\xac\x18\x82\xdcu\xd5\xd5\x8e<\xb3\xe4\x85e\xddX\xca0;\xe2G\xef7\\uM\x8d0A\xde+\x9fu'

```







reference: [https://blog.maple3142.net/2022/06/06/seetf-2022-writeups/](https://blog.maple3142.net/2022/06/06/seetf-2022-writeups/)

Thanks for reading. Have a good day :heart: !
