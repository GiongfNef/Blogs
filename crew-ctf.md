---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# Crew CTF

### ez-x0r

```
BRQDER1VHDkeVhQ5BRQfFhIJGw==
```

* Convert to hex than xor with some char?
* i brute force xor string with ascii and got flag when i xor with 66

> crew{3z\_x0r\_crypto}

### The HUGE e

chall

```
from Crypto.Util.number import getPrime, bytes_to_long, inverse, isPrime
from secret import flag

m = bytes_to_long(flag)

def getSpecialPrime():
    a = 2
    for i in range(40):
        a*=getPrime(20)
    while True:
        b = getPrime(20)
        if isPrime(a*b+1):
            return a*b+1


p = getSpecialPrime()
e1 = getPrime(128)
e2 = getPrime(128)
e3 = getPrime(128)

e = pow(e1,pow(e2,e3))
c = pow(m,e,p)

assert pow(c,inverse(e,p-1),p) == m

print(f'p = {p}')
print(f'e1 = {e1}')
print(f'e2 = {e2}')
print(f'e3 = {e3}')
print(f'c = {c}')

# p = 127557933868274766492781168166651795645253551106939814103375361345423596703884421796150924794852741931334746816404778765897684777811408386179315837751682393250322682273488477810275794941270780027115435485813413822503016999058941190903932883823
# e1 = 219560036291700924162367491740680392841
# e2 = 325829142086458078752836113369745585569
# e3 = 237262361171684477270779152881433264701
# c = 962976093858853504877937799237367527464560456536071770645193845048591657714868645727169308285896910567283470660044952959089092802768837038911347652160892917850466319249036343642773207046774240176141525105555149800395040339351956120433647613
```

solve

```
from Crypto.Util.number import long_to_bytes

p = 127557933868274766492781168166651795645253551106939814103375361345423596703884421796150924794852741931334746816404778765897684777811408386179315837751682393250322682273488477810275794941270780027115435485813413822503016999058941190903932883823
e1 = 219560036291700924162367491740680392841
e2 = 325829142086458078752836113369745585569
e3 = 237262361171684477270779152881433264701
c = 962976093858853504877937799237367527464560456536071770645193845048591657714868645727169308285896910567283470660044952959089092802768837038911347652160892917850466319249036343642773207046774240176141525105555149800395040339351956120433647613

phiP = p - 1
phiphiP = 63775594668498404422995279661693309334486076035802944116275814269950078792958445557761589097717204934857369990271713664698474867142217580223510594284968730411939236198524531363514002763605853593498040656788050786948899096447734618521600000000

subE = pow(e2, e3, phiphiP)
e = pow(e1, subE, p - 1)
d = pow(e, -1, p - 1)
pt = pow(c, d, p)
print(long_to_bytes(pt))
```

### Malleable Metal

```
from Crypto.PublicKey import RSA
from Crypto.Util.number import bytes_to_long
import random
import binascii
from secret import flag

e = 3
BITSIZE =  8192
key = RSA.generate(BITSIZE)
n = key.n
flag = bytes_to_long(flag)
m = floor(BITSIZE/(e*e)) - 400
assert (m < BITSIZE - len(bin(flag)[2:]))
r1 = random.randint(1,pow(2,m))
r2 = random.randint(r1,pow(2,m))
msg1 = pow(2,m)*flag + r1
msg2 = pow(2,m)*flag + r2
C1 = Integer(pow(msg1,e,n))
C2 = Integer(pow(msg2,e,n))
print(f'{n = }\n{C1 = }\n{C2 = }')
```

![](<.gitbook/assets/image (2).png>)

### toydl

```
import sys
from Crypto.Util.number import long_to_bytes, inverse, GCD
import gmpy2
from pwn import *

proc = remote('toydl.crewctf-2022.crewc.tf', 1337)
proc.recvline()
n = int(proc.recvline().strip(b'\n').split(b': ')[1])
proc.recvline()
proc.recvline()
e = 65537
encflag = int(proc.recvline().strip(b'\n'))
proc.recvline()
proc.recvline()
proc.recvline()

print(n)

result = {}
while(True):
    firstline = proc.recvline().strip(b'\n')
    if firstline == b"I'm bored.":
        proc.close()
        break
    base = int(firstline.split(b'pow(')[1].split(b',')[0])
    number = int(firstline.split(b' = ')[1])
    dl = int(proc.recvline().strip(b'\n').split(b'->')[1])
    result[(base, number)] = dl
    proc.recvline()

def factor(base, baseorder):
    if baseorder == 0:
        return False
    i = 1
    while(baseorder % (2**i) == 0):
        cand = pow(base, baseorder//(2**i), n)
        if cand != 1:
            p = GCD(cand+1, n)
            if p > 1 and p < n:
                q = n // p
                d = inverse(e, (p-1)*(q-1))
                print(b'FOUND: ' + long_to_bytes(pow(encflag, d, n)))
                return True
        i += 1
    return False

found = False
# base1**x = a, (a**k)**y = base1**l
for base1 in (2,3,5,6,7):
    for number1 in range(2, 10):
        for k in range(1, 4):
            for l in range(1, 4):
                if (base1, number1) in result.keys() and (number1**k, base1**l) in result.keys():
                    dl1 = result[(base1, number1)]
                    dl2 = result[(number1**k, base1**l)]
                    base1order = dl1*dl2*k-l
                    assert pow(base1, base1order, n) == 1
                    found = factor(base1, base1order)
                if found:
                    break
            if found:
                break
        if found:
            break
    if found:
        break
if found:
    sys.exit(0)

# base1**x = a, (a**k)**y = base1.sqrt**l
for base1 in (4, 9):
    base1_sqrt = int(gmpy2.iroot(base1, 2)[0])
    for number1 in range(2, 10):
        for k in range(1, 4):
            for l in range(1, 4):
                if (base1, number1) in result.keys() and (number1**k, base1_sqrt**l) in result.keys():
                    dl1 = result[(base1, number1)]
                    dl2 = result[(number1**k, base1_sqrt**l)]
                    base1_sqrtorder = 2*dl1*dl2*k-l
                    assert pow(base1_sqrt, base1_sqrtorder, n) == 1
                    found = factor(base1_sqrt, base1_sqrtorder)
                if found:
                    break
            if found:
                break
        if found:
            break
    if found:
        break
if found:
    sys.exit(0)

# base1**x = a, (a**k)**y = base1.cubert**l
for base1 in (8,):
    base1_cubic = int(gmpy2.iroot(base1, 3)[0])
    for number1 in range(2, 10):
        for k in range(1, 4):
            for l in range(1, 4):
                if (base1, number1) in result.keys() and (number1**k, base1_cubic**l) in result.keys():
                    dl1 = result[(base1, number1)]
                    dl2 = result[(number1**k, base1_cubic**l)]
                    base1_cubicorder = 3*dl1*dl2*k-l
                    assert pow(base1_cubic, base1_cubicorder, n) == 1
                    found = factor(base1_cubic, base1_cubicorder)
                if found:
                    break
            if found:
                break
        if found:
            break
    if found:
        break
if found:
    sys.exit(0)

# (base1.0*base1.1)**x = a, (a**k)**y0 = base1.0**l, (a**k)**y1 = base1.1**l
for number1 in range(2, 10):
    for k in range(1, 4):
        if (6, number1) in result.keys() and (number1**k, 2) in result.keys() and (number1**k, 3) in result.keys():
            dl1 = result[(6, number1)]
            dl2 = result[(number1**k, 2)]
            dl3 = result[(number1**k, 3)]
            six_order = dl1*k*(dl2+dl3)-1
            assert pow(6, six_order, n) == 1
            found = factor(6, six_order)
        if found:
            break
        if (6, number1) in result.keys() and (number1**k, 4) in result.keys() and (number1**k, 9) in result.keys():
            dl1 = result[(6, number1)]
            dl2 = result[(number1**k, 4)]
            dl3 = result[(number1**k, 9)]
            six_order = dl1*k*(dl2+dl3)-2
            assert pow(6, six_order, n) == 1
            found = factor(6, six_order)
        if found:
            break
    if found:
        break
if found:
    sys.exit(0)

# base1**x = a, (base1**k)**y = a**l
for base1 in range(2, 10):
    for number1 in range(2, 10):
        for k in range(1, 4):
            for l in range(1, 4):
                if (base1, number1) in result.keys() and (base1**k, number1**l) in result.keys():
                    dl1 = result[(base1, number1)]
                    dl2 = result[(base1**k, number1**l)]
                    base1_order = abs(dl1*l - k*dl2)
                    assert pow(base1, base1_order, n) == 1
                    found = factor(base1, base1_order)
                if found:
                    break
            if found:
                break
        if found:
            break
    if found:
        break
if found:
    sys.exit(0)


print("NOTFOUND")
```

### Delta

```
from __future__ import print_function
import time

debug = True

# display matrix picture with 0 and X
def matrix_overview(BB, bound):
    for ii in range(BB.dimensions()[0]):
        a = ('%02d ' % ii)
        for jj in range(BB.dimensions()[1]):
            a += '0' if BB[ii,jj] == 0 else 'X'
            a += ' '
        if BB[ii, ii] >= bound:
            a += '~'
        print(a)

def coppersmith_howgrave_univariate(pol, modulus, beta, mm, tt, XX):
    """
    Coppersmith revisited by Howgrave-Graham
    
    finds a solution if:
    * b|modulus, b >= modulus^beta , 0 < beta <= 1
    * |x| < XX
    """
    #
    # init
    #
    dd = pol.degree()
    nn = dd * mm + tt

    #
    # checks
    #
    if not 0 < beta <= 1:
        raise ValueError("beta should belongs in (0, 1]")

    if not pol.is_monic():
        raise ArithmeticError("Polynomial must be monic.")

    #
    # calculate bounds and display them
    #
    """
    * we want to find g(x) such that ||g(xX)|| <= b^m / sqrt(n)
    * we know LLL will give us a short vector v such that:
    ||v|| <= 2^((n - 1)/4) * det(L)^(1/n)
    * we will use that vector as a coefficient vector for our g(x)
    
    * so we want to satisfy:
    2^((n - 1)/4) * det(L)^(1/n) < N^(beta*m) / sqrt(n)
    
    so we can obtain ||v|| < N^(beta*m) / sqrt(n) <= b^m / sqrt(n)
    (it's important to use N because we might not know b)
    """
    if debug:
        # t optimized?
        print("\n# Optimized t?\n")
        print("we want X^(n-1) < N^(beta*m) so that each vector is helpful")
        cond1 = RR(XX^(nn-1))
        print("* X^(n-1) = ", cond1)
        cond2 = pow(modulus, beta*mm)
        print("* N^(beta*m) = ", cond2)
        print("* X^(n-1) < N^(beta*m) \n-> GOOD" if cond1 < cond2 else "* X^(n-1) >= N^(beta*m) \n-> NOT GOOD")
        
        # bound for X
        print("\n# X bound respected?\n")
        print("we want X <= N^(((2*beta*m)/(n-1)) - ((delta*m*(m+1))/(n*(n-1)))) / 2 = M")
        print("* X =", XX)
        cond2 = RR(modulus^(((2*beta*mm)/(nn-1)) - ((dd*mm*(mm+1))/(nn*(nn-1)))) / 2)
        print("* M =", cond2)
        print("* X <= M \n-> GOOD" if XX <= cond2 else "* X > M \n-> NOT GOOD")

        # solution possible?
        print("\n# Solutions possible?\n")
        detL = RR(modulus^(dd * mm * (mm + 1) / 2) * XX^(nn * (nn - 1) / 2))
        print("we can find a solution if 2^((n - 1)/4) * det(L)^(1/n) < N^(beta*m) / sqrt(n)")
        cond1 = RR(2^((nn - 1)/4) * detL^(1/nn))
        print("* 2^((n - 1)/4) * det(L)^(1/n) = ", cond1)
        cond2 = RR(modulus^(beta*mm) / sqrt(nn))
        print("* N^(beta*m) / sqrt(n) = ", cond2)
        print("* 2^((n - 1)/4) * det(L)^(1/n) < N^(beta*m) / sqrt(n) \n-> SOLUTION WILL BE FOUND" if cond1 < cond2 else "* 2^((n - 1)/4) * det(L)^(1/n) >= N^(beta*m) / sqroot(n) \n-> NO SOLUTIONS MIGHT BE FOUND (but we never know)")

        # warning about X
        print("\n# Note that no solutions will be found _for sure_ if you don't respect:\n* |root| < X \n* b >= modulus^beta\n")
    
    #
    # Coppersmith revisited algo for univariate
    #

    # change ring of pol and x
    polZ = pol.change_ring(ZZ)
    x = polZ.parent().gen()

    # compute polynomials
    gg = []
    for ii in range(mm):
        for jj in range(dd):
            gg.append((x * XX)**jj * modulus**(mm - ii) * polZ(x * XX)**ii)
    for ii in range(tt):
        gg.append((x * XX)**ii * polZ(x * XX)**mm)
    
    # construct lattice B
    BB = Matrix(ZZ, nn)

    for ii in range(nn):
        for jj in range(ii+1):
            BB[ii, jj] = gg[ii][jj]

    # display basis matrix
    if debug:
        matrix_overview(BB, modulus^mm)

    # LLL
    BB = BB.LLL()

    # transform shortest vector in polynomial    
    new_pol = 0
    for ii in range(nn):
        new_pol += x**ii * BB[0, ii] / XX**ii

    # factor polynomial
    potential_roots = new_pol.roots()
    print("potential roots:", potential_roots)

    # test roots
    roots = []
    for root in potential_roots:
        if root[0].is_integer():
            result = polZ(ZZ(root[0]))
            if gcd(modulus, result) >= modulus^beta:
                roots.append(ZZ(root[0]))

    # 
    return roots

############################################
# Test on Stereotyped Messages
##########################################    

print("//////////////////////////////////")
print("// TEST 1")
print("////////////////////////////////")

# RSA gen options (for the demo)
length_N = 1024  # size of the modulus
Kbits = 200      # size of the root
e = 3

# RSA gen (for the demo)
p = next_prime(2^int(round(length_N/2)))
q = next_prime(p)
N = p*q
ZmodN = Zmod(N);
n=141100651008173851466795684636324450409238358207191893767666902216680426313633075955718286598033724188672134934209410772467615432454991738608692590241240654619365943145665145916032591750673763981269787196318669195238077058469850912415480579793270889088523790675069338510272116812307715222344411968301691946663
e=65537
c=115338511096061035992329313881822354869992148130629298132719900320552359391836743522134946102137278033487970965960461840661238010620813848214266530927446505441293867364660302604331637965426760460831021145457230401267539479461666597608930411947331682395413228540621732951917884251567852835625413715394414182100
val=55719322748654060909881801139095138877488925481861026479419112168355471570782990525463281061887475459280827193232049926790759656662867804019857629447612576114575389970078881483945542193937293462467848252776917878957280026606366201486237691429546733291217905881521367369936019292373732925986239707922361248585

# Create problem (for the demo)
K = ZZ.random_element(0, 2^Kbits)
Kdigits = K.digits(2)
M = [0]*Kbits + [1]*(length_N-Kbits); 
for i in range(len(Kdigits)):
    M[i] = Kdigits[i]
M = ZZ(M, 2)
C = ZmodN(M)^e

# Problem to equation (default)
P.<x> = PolynomialRing(Zmod(n)) #, implementation='NTL')
f = (pow(2,e,n)*(x)**3) + pow(3,e,n)*(x)**2 + pow(5,e,n)*(x) + pow(7,e,n) -val
f=f.monic()

# Coppersmith
start_time = time.time()
roots = coppersmith_howgrave_univariate(f, n, 1, 4, 12, 2^64)

# output

print("we found:", str(roots))
```

```
from Crypto.PublicKey import RSA
from Crypto.Util.number import *
from Crypto.Cipher import PKCS1_OAEP
from Crypto.Hash import SHA256
import random
import binascii
import math


n=141100651008173851466795684636324450409238358207191893767666902216680426313633075955718286598033724188672134934209410772467615432454991738608692590241240654619365943145665145916032591750673763981269787196318669195238077058469850912415480579793270889088523790675069338510272116812307715222344411968301691946663
e=65537
c=115338511096061035992329313881822354869992148130629298132719900320552359391836743522134946102137278033487970965960461840661238010620813848214266530927446505441293867364660302604331637965426760460831021145457230401267539479461666597608930411947331682395413228540621732951917884251567852835625413715394414182100
val=55719322748654060909881801139095138877488925481861026479419112168355471570782990525463281061887475459280827193232049926790759656662867804019857629447612576114575389970078881483945542193937293462467848252776917878957280026606366201486237691429546733291217905881521367369936019292373732925986239707922361248585
delta = 16660334173862742020

m = (pow(2,e)*pow(delta,3) + pow(3,e)*pow(delta,2) + pow(5,e)*delta + pow(7,e)) %n
tmp = (val-m)%n
q=math.gcd(tmp,n)
p=n//q
phi = (p-1)*(q-1)
d= pow(e,-1,phi)

key = RSA.construct((n,e,d,p,q))
cipher = PKCS1_OAEP.new(key=key,hashAlgo=SHA256)
flag = cipher.decrypt(long_to_bytes(c))
print(flag)
```
