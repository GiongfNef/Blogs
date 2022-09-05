---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
cover: ../../.gitbook/assets/Hachi.jpg
coverY: 0
---

# picoCTF 2022 + wscCTF 2022

## picoCTF 2022

### Crypto

#### basic-mod1

Following the decription:

> Take each number mod 37 and map it to the following character set: 0-25 is the alphabet (uppercase), 26-35 are the decimal digits, and 36 is an underscore.

simple code:

```
m = [387 ,248 ,131 ,272 ,373, 221,161 ,110 ,91 ,359 ,390 ,50, 225 ,184 ,223 ,137 ,225 ,327, 42, 179, 220 ,365] 
import string
alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
flag = ''
for i in m:
    if int(i%37) in test:
        for j in alpha:
            if alpha.index(j) == int(i%37) :
                flag += j
    elif int(i%37)!= 36:
        flag += str(int(i%37)%26)
    else:
        flag += '_'
print(flag)
#R0UND_N_R0UND_B0D5F596 

```

#### basic-mod2

Following the decription:

> Take each number mod 41 and find the modular inverse for the result. Then map to the following character set: 1-26 are the alphabet, 27-36 are the decimal digits, and 37 is an underscore.

solve:

```
m = [145 ,126, 356, 272, 98 ,378 ,395 ,352, 392 ,215 ,446, 168 ,180 ,359 ,51, 190, 404, 209, 185, 115 ,363, 431 ,103 ] 
import string
alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '
test = [0,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
flag = ''
enc = [28, 13, 21, 30, 17, 32, 30, 11, 24, 37, 7, 31, 17, 3, 37, 30, 34, 31, 1, 4, 34, 1, 1] #-1 
#     [28, 14, 22, 30, 18, 32, 30, 12, 25, 37, 8, 31, 18, 4, 37, 30, 34, 31, 2, 5, 34, 2, 2] 

for i in enc:
    if i in test:
        for j in alpha:
            if alpha.index(j) == i :
                flag += j
    elif i != 37:
        flag += str(i %27 )
    else:
        flag += '_'
print(flag)
# 1NV3R53LY_H4RD_374BE7BB
```

#### credstuff

find `cultiris` 's password: cvpbPGS{P7e1S\_54I35\_71Z3}

rot13: picoCTF{C7r1F\_54V35\_71M3}

#### morse-code

we can you [tool online](https://morsecode.world/international/decoder/audio-decoder-adaptive.html)

flag: picoCTF{WH47 H47H 90D W20U9H7}

#### rail-fence

[tool](https://www.boxentriq.com/code-breaking/rail-fence-cipher)

![](<../../.gitbook/assets/image (18) (1).png>)

#### substitution0

If you studied cryptography of Mr Tu in UIT, you could solve this chall by eyes =D

> The flag is: picoCTF{5UB5717U710N\_3V0LU710N\_F96A338E}

#### substitution1

same one

> flag is: picoCTF{FR3QU3NCY\_4774CK5\_4R3\_C001\_3645BEC6}

#### substitution2

> THEFLAGISPICOCTF{N6R4M\_4N41Y515\_15\_73D10U5\_C823D467}

#### transposition-trial

```
heTfl g as iicpCTo{7F4NRP051N5_16_35P3X51N3_V8450214}1
```

Notice that:&#x20;

* "but every block of 3 got scrambled around!"
* if we shift char of "iicpCTo" first \[0] to \[3] we can get "piciCTo" than "picoCTi" continue do that until the last char is '" i ".

some code for loving:

```
m ='iicpCTo{7F4NRP051N5_16_35P3X51N3_V8450214}1'

m = list(m)
def solve(s):
   s = list(s)
   for i in range(0, len(s)-1,3):
      s[i], s[i+3] = s[i+3], s[i]

   return ''.join(s)

print(solve(m)) 
#picoCTF{7R4N5P051N6_15_3XP3N51V3_58410214}i
```

#### Vigenere

decrypt Vigenere with key: "CYLAB". That's quite easy.

> picoCTF{D0NT\_US3\_V1G3N3R3\_C1PH3R\_0df54reb}

#### diffie-hellman

* Actually this chall want us to find key by diffie-hellman then decrypt Caesar with that key
* However, we can brute force they key without using diffie-hellman so that this chall have been deleted in picoCTF

#### Very Smooth

``[`smooth number`](https://en.wikipedia.org/wiki/Smooth\_number)``

```
def get_prime(state, bits):
    return next_prime(mpz_urandomb(state, bits) | (1 << (bits - 1)))

def get_smooth_prime(state, bits, smoothness=16):
    p = mpz(2)
    p_factors = [p]
    while p.bit_length() < bits - 2 * smoothness:
        factor = get_prime(state, smoothness)
        p_factors.append(factor)
        p *= factor

    bitcnt = (bits - p.bit_length()) // 2

    while True:
        prime1 = get_prime(state, bitcnt)
        prime2 = get_prime(state, bitcnt)
        tmpp = p * prime1 * prime2
        if tmpp.bit_length() < bits:
            bitcnt += 1
            continue
        if tmpp.bit_length() > bits:
            bitcnt -= 1
            continue
        if is_prime(tmpp + 1):
            p_factors.append(prime1)
            p_factors.append(prime2)
            p = tmpp + 1
            break

    p_factors.sort()

    return (p, p_factors)
```

* You can code simple script  as this [guy](https://ctftime.org/writeup/32852)

> In my situation, i use the [primefac](https://pypi.org/project/primefac/)

![](<../../.gitbook/assets/image (23).png>)

flag: picoCTF{94287e17}

#### Sequences

#### Sum-O-Primes



#### NSA Backdoor

> #### <mark style="color:blue;">At this point, my ancestor told me to do anything so I won't write anything from now on,</mark>&#x20;
>
> #### <mark style="color:blue;">thank you for reading!</mark>

flag: picoCTF{_Yu\_toi\_nho\_em!_}

****![](<../../.gitbook/assets/image (27) (1) (1).png>)****

****



### Web

#### Includes

#### Inspect HTML

#### Local Authority

#### Search source

#### Power Cookie

#### Roboto Sans

#### SQLiLite

## wscCTF 2022

### Crypto

#### ANYTHING

```
This could be encrypted with ANYTHING! wfa{oporteec_gvb_ogd}
```

Vernam Cipher (One Time Pad Vigenere) =>flag: <mark style="color:blue;">WSC{VIGENERE\_NOT\_BAD}</mark>

#### RSA With The Dogs

source: gen.sage

```
from random import getrandbits
from Crypto.Util.number import bytes_to_long

p = random_prime(2^(1024//2),False,2^(1023//2))
q = random_prime(2^(1024//2),False,2^(1023//2))

n = p*q
phi = (p-1) * (q-1)

done = False
while not done:
    d = getrandbits(1024//4)
    if (gcd(d,phi) == 1 and 36*pow(d,4) < n):
        done = True
                

Flag = open('flag.txt').read().encode()
m=bytes_to_long(Flag)
e = Integer(d).inverse_mod(phi)
c=pow(m,e,n)
print("n =",n)
print("e =",e)
print("c =",c)

n = 80958280137410344469270793621735550547403923964041971008952114628165974409360380289792220885326992426579868790128162893145613324338067958789899179419581085862309223717281585829617191377490590947730109453817502130283318153315193437990052156404947863059961976057429879645314342452813233368655425822274689461707
e = 3575901247532182907389411227211529824636724376722157756567776602226084740339294992167070515627141715229879280406393029563498781044157896403506408797685517148091205601955885898295742740813509895317351882951244059944509598074900130252149053360447229439583686319853300112906033979011695531155686173063061146739
c = 80629080505342932586166479028264765764709326746119909040860609021743893395577080637958779561184335633322859567681317501709922573784403504695809067898870536224427948000498261469984511352960143456934810825186736399371084350678586129000118485271831798923746976704036847707653422361120164687989605124465224952493

assert(int(pow(c,d,n)) == m)
```

<mark style="color:red;">Notice</mark>: 36\*pow(d,4) < n => P,Q computed with N,E (Wiener's attack)

flag: <mark style="color:blue;">wsc{w13n3r5\_wer3\_bre4d\_t0\_hunt\_b4dger5!}</mark>

#### EAV-Secure Diffie–Hellman?

source: key\_exchange.py

```
from Crypto.Util.number import bytes_to_long

# I love making homespun cryptographic schemes!

def diffie_hellman():
    f = open("flag.txt", "r")
    flag = f.read()
    a = bytes_to_long(flag.encode('utf-8'))
    p = 320907854534300658334827579113595683489
    g = 3
    A = pow(g,a,p) #236498462734017891143727364481546318401

if __name__ == "__main__":
    diffie_hellman()

# EAV-Secure? What's that?
```

Workflow:

* A = pow(g,a,p) of course that's discrete log, i used sage math to calculate easily and get this result:

![](<../../.gitbook/assets/image (38) (1).png>)

* Nice, let's decrypt and gonna flag

![](<../../.gitbook/assets/image (2) (1) (1).png>)

* Hmm this one's no meaning. May i am wrong in somewhere ?&#x20;

![](<../../.gitbook/assets/image (37) (1) (1).png>)

* No, i ensure my result !
* At this time i review the code and notice that:&#x20;

```
f = open("flag.txt", "r")
flag = f.read()
a = bytes_to_long(flag.encode('utf-8'))
```

* Here we can see that flag may be bigger than p or flag may be add with phi(p) then after calculating modulo we'll get the same result. That is  [<mark style="color:blue;">Fermat's little theorem</mark>](https://en.wikipedia.org/wiki/Fermat's\_little\_theorem)<mark style="color:blue;">.</mark>&#x20;
* Implement the idea!

```
from Crypto.Util.number import *

flag = 67514057458967447420279566091192598301
p = 320907854534300658334827579113595683489
g = 3
A = 236498462734017891143727364481546318401
for i in range(10000000):
	flag_here = long_to_bytes(flag+(i*(p-1)))
	if b'wsc{' in flag_here:
		print(flag_here,'ehehhehhehhehe')
		break
	print(i)
```

![](<../../.gitbook/assets/image (32) (1).png>)

After bruteforcing 8300951 times, you will get the flag :))))))&#x20;

### Web

``[`link full file`](https://drive.google.com/drive/folders/14YIzr04T3z1TBsxIzGWS7ZNAOPoRw8oC?usp=sharing)``

#### Warmup: Burp

Just check history of burpsuite

We can see the redirect, send the request with cookie to get flag

#### SSRF 101

Notice the port, that's quite interting when private 1's port is 1001 and private2's is 10011 so that we can bypass with /ssrf?path=1/flag/

#### SSRF 301

we can see this clearly in [<mark style="color:blue;">SSRF</mark> ](https://book.hacktricks.xyz/pentesting-web/ssrf-server-side-request-forgery)<mark style="color:blue;">.</mark>

> ```
> dict://<user>;<auth>@<host>:<port>/d:<word>:<database>:<n>
> ```

Actually this one is standard of host and port for example:

![](<../../.gitbook/assets/image (10) (1) (1).png>)

In this situation,the host is gg.com, we connect to this one.

![](<../../.gitbook/assets/image (5) (2).png>)

However, if we insert the symbol @ it will undertstand user:pass before @ and host:port after.

Now user is gg.com and fb.com is host.

payload: /ssrf?path=a@localhost:/private2:10011/flag/

Thanks for reading. Have a good day :heart: !



Contact:

* <mark style="color:blue;">``</mark><img src="../../.gitbook/assets/image (6) (1).png" alt="" data-size="line"><mark style="color:blue;">``</mark>[<mark style="color:blue;">`facebook`</mark> ](https://www.facebook.com/rong.truong.372)<mark style="color:blue;">``</mark>

