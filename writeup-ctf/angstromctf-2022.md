---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# ångstromCTF 2022

![](<../.gitbook/assets/image (24) (1).png>)

### Caesar and Desister

> sulx{klgh\_jayzl\_lzwjw\_ujqhlgyjshzwj\_kume}

![](<../.gitbook/assets/image (13) (1).png>)

### Randomly Sampled Algorithm

![](<../.gitbook/assets/image (39) (1) (1) (1).png>)

### Vinegar Factory

#### Source

```
#!/usr/local/bin/python3

import string
import os
import random

with open("flag.txt", "r") as f:
    flag = f.read().strip()

alpha = string.ascii_lowercase

def encrypt(msg, key):
    ret = ""
    i = 0
    for c in msg:
        if c in alpha:
            ret += alpha[(alpha.index(key[i]) + alpha.index(c)) % len(alpha)]
            i = (i + 1) % len(key)
        else:
            ret += c
    return ret

inner = alpha + "_"
noise = inner + "{}"

print("Welcome to the vinegar factory! Solve some crypto, it'll be fun I swear!")

i = 0
while True:
    if i % 50 == 49:
        fleg = flag
    else:
        fleg = "actf{" + "".join(random.choices(inner, k=random.randint(10, 50))) + "}"
    start = "".join(random.choices(noise, k=random.randint(0, 2000)))
    end = "".join(random.choices(noise, k=random.randint(0, 2000)))
    key = "".join(random.choices(alpha, k=4))
    print(f"Challenge {i}: {start}{encrypt(fleg + 'fleg', key)}{end}")
    x = input("> ")
    if x != fleg:
        print("Nope! Better luck next time!")
        break
    i += 1

```

#### Overview

When connect to the server:

![](<../.gitbook/assets/image (12).png>)

#### Analysis:

* Easily to see that we have to bypass 50 levels of this chall to get the flag
* The length of key is 4
* The strange code is {start}{encrypt(fleg + 'fleg', key)}{end}
* That means,  {start} and {end} are random from noise
* Fake flag is random from inner, now we can determind the position of char '{', '}' and '\_' because they aren't encrypted
* The most important thing is: the server has a 20 second timeout so that we have to use pwntools  for scripting.

#### Idea:

* Notice that encrypt(fleg + 'fleg', key) this means when plaintext's encrypted it would be like: ![](<../.gitbook/assets/image (37) (1).png>)
* From this we can guess the last 4 characters is the cipher of 'fleg' then we can find the key easily by decrypt Vigenere, finally use the key to decrypt flag.

#### Solve

```
import string
import os
import random
import re
from itertools import permutations
from pwn import * 

p= remote("challs.actf.co", 31333)

for Y in range(50):
	message = p.recvuntil("\n> ",drop= True).decode()
	if Y < 10:
		line = message[86:]
	else:
		line = message[87:]
	alpha = string.ascii_lowercase
	inner = alpha + "_"
	k = 5
	head = []
	head= ([i.start() for i in re.finditer('{', line)])
	tail= ([i.start() for i in re.finditer('}', line)])
	flag = []
	for i in head:
		for j in tail:
			if i<2000  and j-i >= 10 and j-i <= 50 and line[i-4] in inner and line[i-3] in inner and line[i-2] in inner and line[i-1] in inner:  
				try:
					if line[j+4] in inner and line[j+3] in inner and line[j+2] in inner and line[j+1] in inner and len(line[i+1:j]) >= 10:
						if '{' not in line[i+1:j] and '}' not in line[i+1:j]:
							flag.append(line[i-4:j+5])
				except:
					continue
	def convertTuple(tup):
			# initialize an empty string
		str = ''
		for item in tup:
			str = str + item
		return str

	def decrypt(cipher, key):
		ret = ""
		i = 0
		for c in cipher:
			if c in alpha:
				ret += alpha[alpha.index(c)-(alpha.index(key[i]) ) % len(alpha)]
				i = (i + 1) % len(key)
			else:
				ret += c
		return ret
	def find_key(cipher, msg):
		ret = ""
		i = 0
		for i in range(0,4):
				ret += alpha[alpha.index(cipher[i])-(alpha.index(msg[i]) ) % len(alpha)]
		return ret
	may_be_flag = []
	def allPermutations(str):
		   
		 # Get all permutations of string 'ABC'
		permList = permutations(str)
	  
		 # print all permutations
		for i in permList:
			i = convertTuple(i)
			for f in flag:
				try:
					may_be_flag.append(decrypt(f[:-4],i))
				except:
					continue

	key_list = []
	for i in flag:
		try:
			key = find_key(i[-4:],'fleg')
		except:
			continue
		key_list.append(key)

	for i in key_list:
		allPermutations(i)
	superplag = []
	for i in may_be_flag:
		if 'actf' in i:
			print(i,Y)
			p.sendline(i)
			break
	
```

### log log log

#### Source

```
from secrets import randbits
from flag import flag

flagbits = len(flag) * 8
flag = int(flag.hex(),16)

q = 127049168626532606399765615739991416718436721363030018955400489736067198869364016429387992001701094584958296787947271511542470576257229386752951962268029916809492721741399393261711747273503204896435780180020997260870445775304515469411553711610157730254858210474308834307348659449375607755507371266459204680043
p = q * 2^1024 + 1

assert p in Primes()

nbits = p.nbits()-1

e = randbits(nbits-flagbits)
e <<= flagbits
e |= flag

K = GF(p)
g = K.multiplicative_generator()
a = g^e

print(hex(p))
print(g)
print(hex(a))
print(flagbits)

#0xb4ec8caf1c16a20c421f4f78f3c10be621bc3f9b2401b1ecd6a6b536c9df70bdbf024d4d4b236cbfcb202b702c511aded6141d98202524709a75a13e02f17f2143cd01f2867ca1c4b9744a59d9e7acd0280deb5c256250fb849d96e1e294ad3cf787a08c782ec52594ef5fcf133cd15488521bfaedf485f37990f5bd95d5796b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
#3
#0xaf99914e5fb222c655367eeae3965f67d8c8b3a0b3c76c56983dd40d5ec45f5bcde78f7a817dce9e49bdbb361e96177f95e5de65a4aa9fd7eafec1142ff2a58cab5a755b23da8aede2d5f77a60eff7fb26aec32a9b6adec4fe4d5e70204897947eb441cc883e4f83141a531026e8a1eb76ee4bff40a8596106306fdd8ffec9d03a9a54eb3905645b12500daeabdb4e44adcfcecc5532348c47c41e9a27b65e71f8bc7cbdabf25cd0f11836696f8137cd98088bd244c56cdc2917efbd1ac9b6664f0518c5e612d4acdb81265652296e4471d894a0bd415b5af74b9b75d358b922f6b088bc5e81d914ae27737b0ef8b6ac2c9ad8998bd02c1ed90200ad6fff4a37
#880
```

#### Analysis

* p = q \* 2^1024 + 1
* Actually, from 3 lines we know that the 880 lowest bits of e are the bits of flag
* ```
  e = randbits(nbits-flagbits)
  e <<= flagbits
  e |= flag
  ```
* Now the challenge is return how to solve the discrete log problem

#### Idea

* To solve this, we have to know a little bit about [<mark style="color:blue;">Legendre symbol</mark>](https://en.wikipedia.org/wiki/Legendre\_symbol) <mark style="color:blue;"></mark> then i got an interesting thing:

![](<../.gitbook/assets/image (16).png>)

* That mean if r is even or the least significant bit is 0 then x is a quadratic residue (legendre\_symbol(a, p) == 1)&#x20;
* Otherwise, r is odd and (legendre\_symbol(a, p) == 0)&#x20;

#### Solve

```
def legendre_symbol(a, p):
    """ Compute the Legendre symbol a|p using
        Euler's criterion. p is a prime, a is
        relatively prime to p (if p divides
        a, then a|p = 0)
        Returns 1 if a has a square root modulo
        p, -1 otherwise.
    """
    ls = pow(a, (p - 1) // 2, p)
    return -1 if ls == p - 1 else ls
def modular_sqrt(a, p):


    """ Find a quadratic residue (mod p) of 'a'. p
        must be an odd prime.
        Solve the congruence of the form:
            x^2 = a (mod p)
        And returns x. Note that p - x is also a root.
        0 is returned is no square root exists for
        these a and p.
        The Tonelli-Shanks algorithm is used (except
        for some simple cases in which the solution
        is known from an identity). This algorithm
        runs in polynomial time (unless the
        generalized Riemann hypothesis is false).
    """
    # Simple cases
    #
    if legendre_symbol(a, p) != 1:
        return 0
    elif a == 0:
        return 0
    elif p == 2:
        return p
    elif p % 4 == 3:
        return pow(a, (p + 1) // 4, p)

    # Partition p-1 to s * 2^e for an odd s (i.e.
    # reduce all the powers of 2 from p-1)
    #
    s = p - 1
    e = 0
    while s % 2 == 0:
        s //= 2
        e += 1

    # Find some 'n' with a legendre symbol n|p = -1.
    # Shouldn't take long.
    #
    n = 2
    while legendre_symbol(n, p) != -1:
        n += 1

    # Here be dragons!
    # Read the paper "Square roots from 1; 24, 51,
    # 10 to Dan Shanks" by Ezra Brown for more
    # information
    #

    # x is a guess of the square root that gets better
    # with each iteration.
    # b is the "fudge factor" - by how much we're off
    # with the guess. The invariant x^2 = ab (mod p)
    # is maintained throughout the loop.
    # g is used for successive powers of n to update
    # both a and b
    # r is the exponent - decreases with each update
    #
    x = pow(a, (s + 1) // 2, p)
    b = pow(a, s, p)
    g = pow(n, s, p)
    r = e

    while True:
        t = b
        m = 0
        for m in range(r):
            if t == 1:
                break
            t = pow(t, 2, p)

        if m == 0:
            return x

        gs = pow(g, 2 ** (r - m - 1), p)
        g = (gs * gs) % p
        x = (x * gs) % p
        b = (b * g) % p
        r = m
p = 0xb4ec8caf1c16a20c421f4f78f3c10be621bc3f9b2401b1ecd6a6b536c9df70bdbf024d4d4b236cbfcb202b702c511aded6141d98202524709a75a13e02f17f2143cd01f2867ca1c4b9744a59d9e7acd0280deb5c256250fb849d96e1e294ad3cf787a08c782ec52594ef5fcf133cd15488521bfaedf485f37990f5bd95d5796b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
g = 3
a = 0xaf99914e5fb222c655367eeae3965f67d8c8b3a0b3c76c56983dd40d5ec45f5bcde78f7a817dce9e49bdbb361e96177f95e5de65a4aa9fd7eafec1142ff2a58cab5a755b23da8aede2d5f77a60eff7fb26aec32a9b6adec4fe4d5e70204897947eb441cc883e4f83141a531026e8a1eb76ee4bff40a8596106306fdd8ffec9d03a9a54eb3905645b12500daeabdb4e44adcfcecc5532348c47c41e9a27b65e71f8bc7cbdabf25cd0f11836696f8137cd98088bd244c56cdc2917efbd1ac9b6664f0518c5e612d4acdb81265652296e4471d894a0bd415b5af74b9b75d358b922f6b088bc5e81d914ae27737b0ef8b6ac2c9ad8998bd02c1ed90200ad6fff4a37
flagbits = 880

flag = ''
for _ in range(flagbits):
    print(_)
    if legendre_symbol(a, p) == 1:
        flag += '0'
        a = modular_sqrt(a, p)
    elif legendre_symbol(a, p) == -1:
        flag += '1'
        a = modular_sqrt(a * pow(g, -1, p), p)
print(flag)
```



Thanks for reading. Have a good day :heart: !
