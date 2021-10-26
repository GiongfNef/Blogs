---
cover: .gitbook/assets/YuGeineff (1).jpg
coverY: 0
---

# ASISCTF 2021

_**Note : A JOURNEY TO GAIN KNOWLEDGE**_

_**#Warmup**_

```
#!/usr/bin/env python3
 
from Crypto.Util.number import *
import string
from secret import is_valid, flag
 
def random_str(l):
    rstr = ''
    for _ in range(l):
        rstr += string.printable[:94][getRandomRange(0, 93)]
    return rstr
 
def encrypt(msg, nbit):
    l, p = len(msg), getPrime(nbit)
    rstr = random_str(p - l)
    msg += rstr
    while True:
        s = getRandomNBitInteger(1024)
        if is_valid(s, p):
            break
    enc = msg[0]
    for i in range(p-1):
        enc += msg[pow(s, i, p)]
    return enc
 
nbit = 15
enc = encrypt(flag, nbit)
print(f'enc = {enc}')
```

[output.txt](https://github.com/GiongfNef/ChallFile/blob/main/ASISCTF2021/output.txt)

```
with open('output.txt') as f:
    enc = f.read()[6:]
p = len(enc)
print(enc)
for s in range(9900,p-1):
# maybe you can find ASIS{_how_dFC.YptZTh1S?h0mx_m4d;_lGD_w;dr\_CUYpI0_5J2T3+?k!!!*Z} when s = 8562 but it stil wrong
# the correct one is ASIS{_how_d3CrYpt_Th1S_h0m3_m4dE_anD_wEird_CrYp70_5yST3M?!!!!!!} when s = 10927
    flag = ['']*p
    for i in range(p-1):
        flag[pow(s, i, p)] = enc[i+1]
         
    flag = 'A' + ''.join(flag)
    flag = flag.encode()
    if b'ASIS' in flag:
        print(flag)
        break
    print(s)
```
