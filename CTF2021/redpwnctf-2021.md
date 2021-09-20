# redpwnCTF 2021

 _**Note : A JOURNEY TO GAIN KNOWLEDGE**_

**crypto/scissor**

```python
import random

key = random.randint(0, 25)
alphabet = 'abcdefghijklmnopqrstuvwxyz'
shifted = alphabet[key:] + alphabet[:key]
dictionary = dict(zip(alphabet, shifted))

print(''.join([
    dictionary[c]
    if c in dictionary
    else c
    for c in input()
]))
```

**egddagzp\_ftue\_rxms\_iuft\_rxms\_radymf**

Certainly, it's Caesar cipher

> surround\_this\_flag\_with\_flag\_format

**crypto/baby**

n: 228430203128652625114739053365339856393  
e: 65537  
c: 126721104148692049427127809839057445790

RSA? sure :v

> flag{68ab82df34}

**crypto/round-the-bases**

```text
9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:K0o09mTN[9km7D9mTfc:..Zt9mTZ_:IIcu9mTN[9km7D9mTfc:..Zt9mTZ_:Jj8<
```

base85 - &gt; base64 - &gt; hex -&gt; decimal - &gt; octal - &gt; binary

> flag{w0w\_th4t\_w4s\_4ll\_wr4pp3d\_up}

 Thanks for reading. Have a good day &lt;3

