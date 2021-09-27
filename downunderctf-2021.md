# DownUnderCTF 2021

_**Note : A JOURNEY TO GAIN KNOWLEDGE**_

### **\#Substitution Cipher I**

```text
def encrypt(msg, f):
    return ''.join(chr(f.substitute(c)) for c in msg)

P.<x> = PolynomialRing(ZZ)
f = 13*x^2 + 3*x + 7

FLAG = open('./flag.txt', 'rb').read().strip()

enc = encrypt(FLAG, f)
print(enc)
#𖿫𖝓玲𰆽𚃵𒙿疗𛢋𕆛🴃䶹𜑽蒵𜭱𛢋𚃵蒵🴃𜭱𙕑疗𚲳𜭱窇蒵𱫳
```

Comment:

* Through by mapping f\(plaintext\) -&gt; cipher

We just convert cipher to int and solve the quadratic equation to get flag

\# DUCTF{sh0uld'v3\_us3d\_r0t\_13}

### **\# Substitution Cipher II**

```text
from string import ascii_lowercase, digits
CHARSET = "DUCTF{}_!?'" + ascii_lowercase + digits
n = len(CHARSET)

def encrypt(msg, f):
    ct = ''
    for c in msg:
        ct += CHARSET[f.substitute(CHARSET.index(c))]
    return ct

P.<x> = PolynomialRing(GF(n))
f = P.random_element(6)

FLAG = open('./flag.txt', 'r').read().strip()

enc = encrypt(FLAG, f)
print(enc)
```

Comment:

* P.random\_element\(6\) creates polynomial of degree 6, sometimes it misses 1 variable
* f.substitute\(\) substitutes value x then modulo for n because of GF\(n\)
* The idea as **Substitution Cipher I** but we don't have f in this challenge
* Suppose: f\(x\) = a\*x^6 + b\*x^5 + c\*x^4 + d\*x^3 + e\*x^2 + f\*x + g

Idea: We can get whole data from exploiting P.random\_element\(6\) function. Evidently, first base starts at 1, others in \[0,x\) with x &lt; 50 . If we analysic data and calculate the probability, we'll get :

* Value a &gt; 40 : 30%
* The average value of other bases : 15-29

From that data, we can bruteforce all the bases:

```text
# bruteforce
for a in range(1,47):
    for b in range(0,47):
        for c in range(0,47):
            for d in range(0,47):
                for e in range(0,47):
                    for f in range(0,47):
                        if (a+b+c+d+e+f+1)%47 == 20 and (17a+32b+16c+8d+4e+2f +1)%47 ==35 and (24a+8b +34c+27d+9e+3f+1) % 47 ==33 and (7a+37b+21c+17d+16e+4f +1)%47 == 42 and (21a+23b +14c+31d+25e+5f+1)%47 == 14 and (32a+21b+27c+28d+36e+6f+1)%47 == 41:
                            print(a,b,c,d,e,f)
                            break;
    print(a)
    #41 15 40 9 28 27
```

After bruteforcing we get a = 41 :\)\)\)\). Analysicing base d will faster  . [F](https://github.com/GiongfNef/SolveFile/blob/main/DownUnderCTF2021/Substitution%20Cipher%20II_solve.py)[ull\_solve](https://github.com/GiongfNef/SolveFile/blob/main/DownUnderCTF2021/Substitution%20Cipher%20II_solve.py)

\#DUCTF{go0d\_0l'\_l4gr4ng3}

### **\#Break Me!**

```text
#!/usr/bin/python3
import sys
import os
from Crypto.Cipher import AES
from base64 import b64encode

bs = 16 # blocksize
flag = open('flag.txt', 'rb').read().strip()
key = open('key.txt', 'r').read().strip().encode() # my usual password

def enc(pt):
    cipher = AES.new(key, AES.MODE_ECB)
    ct = cipher.encrypt(pad(pt+key))
    res = b64encode(ct).decode('utf-8')
    return res

def pad(pt):
    while len(pt) % bs:
        pt += b'0'
    return (pt)

def main():
    print('AES-128')
    while(1):
        msg = input('Enter plaintext:\n').strip()
        pt = flag + str.encode(msg)
        ct = enc(pt)
        print(ct)

if __name__ == '__main__':
    main()
```

Comment:

* This is block cipher ECB, each block holds 16 characters
* flag + input + key =&gt;if we don't input, we'll get  flag+key
* base64 of flag is constant =&gt; len\(flag\) = 32, len\(key\) = 16
* flag is in block1 and block2, we input from block 3
* \(flag + input + key\) then padding by '0'

![](.gitbook/assets/image%20%281%29.png)

Idea:

* We input 1 character which is bruceforced + '0'\*16, block4 will be '0' + key misses the last character , block5 will be the last character of key + '0'\*15
* Compare block 3 and block 5, if they are equal, we can get the last key's character, do that continually until the key's complete. Having key and cipher =&gt; get flag

```text
from pwn import * 
from Crypto.Util.number import *
import codecs
import base64
import string
p= remote("pwn-2021.duc.tf", 31914) 

char = string.printable

key = ""
k = 0
for k in range(0,16):
    for i in char:
        p.recvuntil("Enter plaintext:\n")
        p.sendline(i + key + 16*'0')
        a = p.recvuntil('\n',drop = True)
        b = base64.b64decode(a)
        if b[32:48] == b[64:80]:
            c = i
            key = c + key
            print(key)
            break

print(key)
#!_SECRETSOURCE_!
```

![](https://giongfnefvblog.files.wordpress.com/2021/09/image-3.png?w=719)

### **\# treasure**

```text
#!/usr/bin/python3

import re
from Crypto.Util.number import long_to_bytes
from Crypto.Random import random
from secret import REAL_COORDS, FLAG_MSG

FAKE_COORDS = 5754622710042474278449745314387128858128432138153608237186776198754180710586599008803960884
p = 13318541149847924181059947781626944578116183244453569385428199356433634355570023190293317369383937332224209312035684840187128538690152423242800697049469987

def create_shares(secret):
    r1 = random.randint(1, p - 1)
    r2 = random.randint(1, p - 1)
    s1 = zr1*r2*secret % p
    s2 = r1*r1*r2*secret % p
    s3 = r1*r2*r2*secret % p
    return [s1, s2, s3]

def reveal_secret(shares):
    s1, s2, s3 = shares
    secret = pow(s1, 3, p) * pow(s2*s3, -1, p) % p
    return secret

def run_combiner(shares):
    try:
        your_share = int(input('Enter your share: '))
        return reveal_secret([your_share, shares[1], shares[2]])
    except:
        print('Invalid share')
        exit()

def is_coords(s):
    try:
        return re.match(r'-?\d+\.\d+?, -?\d+\.\d+', long_to_bytes(s).decode())
    except:
        return False

def main():
    shares = create_shares(REAL_COORDS)
    print(f'Your share is: {shares[0]}')
    print(f'Your two friends input their shares into the combiner and excitedly wait for you to do the same...')

    secret_coords = run_combiner(shares)
    print(f'The secret is revealed: {secret_coords}')
    if not is_coords(secret_coords):
        print('"Hey those don\'t look like coordinates!"')
        print('Your friends grow a bit suspicious, but you manage to convince them that you just entered a digit wrong. You decide to try again...')
    else:
        print('"Let\'s go get the treasure!!"')
        print('Your friends run off to the revealed location to look for the treasure...')
        exit()

    secret_coords = run_combiner(shares)
    if not is_coords(secret_coords):
        print('"This is way too sus!!"')
        exit()

    if secret_coords == FAKE_COORDS:
        print('You\'ve successfully deceived your friends!')

        try:
            real_coords = int(input('Now enter the real coords: '))
            if real_coords == REAL_COORDS:
                print(FLAG_MSG)
            else:
                print('Incorrect!')
        except:
            print('Incorrect!')
    else:
        print('You are a terrible trickster!')

if __name__ == '__main__':
    main()
```

Comment

* When we input shares\[0\], the server responses 'secret', contemporary it calls to exit\(\) function , 'secret 'is constant
* We can bypass the first Function run\_combiner\(shares\) by inputing random intergers 
* So we've to pow\(the input, 3\)  equal to  \(r1\*r2\)^3 \* \(\*secret^2\) \* FAKE\_COORDS

```text
# treasure
def cuberoot(a, p):
    if p == 2:
        return a
    if p == 3:
        return a
    if (p%3) == 2:
        return pow(a,(2*p - 1)//3, p)
    if (p%9) == 4:
        root = pow(a,(2*p + 1)//9, p)
        if pow(root,3,p) == a%p:
            return root
        else:
            return None
    if (p%9) == 7:
        root = pow(a,(p + 2)//9, p)
        if pow(root,3,p) == a%p:
            return root
        else:
            return None
    else:
        print( "Not implemented yet. See the second paper")

# r1 = random.randint(1, p - 1)
# r2 = random.randint(1, p - 1)
# s1 = r1*r2*secret % p
# s2 = r1*r1*r2*secret % p
# s3 = r1*r2*r2*secret % p
secret = 5756627544102572649201219381096443309301530404084814366157678459246004007288774904822314549
FAKE_COORDS = 5754622710042474278449745314387128858128432138153608237186776198754180710586599008803960884
p = 13318541149847924181059947781626944578116183244453569385428199356433634355570023190293317369383937332224209312035684840187128538690152423242800697049469987

s0 = 10746762628325636011924185441153274926904641696665889398587793249399628791439639198296232637211075901379214232485250556903699116729999543184000129920606492

r12= (s0 * pow(secret,-1,p))%p

a = (r12**3)*(secret**2)*FAKE_COORDS

print(cuberoot(a,p))
```

\# DUCTF{m4yb3\_th3\_r34L\_tr34sur3\_w4s\_th3\_fr13nDs\_w3\_m4d3\_al0ng\_Th3\_W4y.......}

Thank for reading ! Have a nice day &lt;3

