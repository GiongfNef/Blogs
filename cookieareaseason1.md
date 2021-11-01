---
cover: .gitbook/assets/248584789_207869758136940_961316915556056214_n.png
coverY: 0
---

# CookieAreaSeason1

_**Note : A JOURNEY TO GAIN KNOWLEDGE**_

### _**#**_**Bruh AES**

**Challenge:**

```
import base64
from Crypto.Cipher import AES

#flag = ###FINDME###
algorithm = AES.MODE_CBC
key = 'supersecretkey!?'
iv_part1 = "0xcafedeadbeef"
iv_part2 = ###FINDME###""
iv = iv_part1 + iv_part2
#assert(len(flag)) == 38

def encrypt(payload, key, iv):
    return AES.new(key, algorithm, iv).encrypt(r_pad(payload))

def r_pad(payload, block_size=16):
    length = block_size - (len(payload) % block_size)
    return payload + chr(length) * length

with open('cipher.txt', 'wb') as f:
    f.write(encrypt(flag, key, iv))Lo
```

Look at this point: iv = iv\_part1 + iv\_part2 .Hmmm actually iv\_part1 = "0xcafedeadbeef" which length is 14 and iv must be 16bytes so that iv\_part2 is also 2 bytes we can bruteforce them. Like this

```
import base64
from Crypto.Cipher import AES
import binascii
from binascii import unhexlify
import string
with open('cipher.txt', 'rb') as f:
	enc = f.read()
def encrypt(payload, key, iv):
	return AES.new(key, algorithm, iv).encrypt(r_pad(payload))

def r_pad(payload, block_size=16):
	length = block_size - (len(payload) % block_size)
	return payload + chr(length) * length
  
def decrypt(payload, key, iv):
	return AES.new(key, algorithm, iv).decrypt(payload)
	
	
algorithm = AES.MODE_CBC
key = 'supersecretkey!?'
iv_part1 = '0xcafedeadbeef'
Anphabet = string.printable
cnt = 0
for a in Anphabet:
	for b in Anphabet:	
		str1 = iv_part1+ a+b				
		
		iv = str1.encode()
							
		flag = decrypt(enc,key,iv)
		if b'Flag' in flag:
			print(flag)
			cnt = 1
			break
		print(flag)
```

but it's not good, because we got too many answer and the flag .... it does not mean and we can't guess neither

![](<.gitbook/assets/image (2).png>)

Finally, i got a hint from my brother. It begins by '0x' so maybe it ends by 'x0' ?????? huh?

```
import base64
from Crypto.Cipher import AES
import binascii
from binascii import unhexlify
import string
with open('cipher.txt', 'rb') as f:
	enc = f.read()
def encrypt(payload, key, iv):
	return AES.new(key, algorithm, iv).encrypt(r_pad(payload))

def r_pad(payload, block_size=16):
	length = block_size - (len(payload) % block_size)
	return payload + chr(length) * length
  
def decrypt(payload, key, iv):
	return AES.new(key, algorithm, iv).decrypt(payload)
	
	
algorithm = AES.MODE_CBC
key = 'supersecretkey!?'
iv_part1 = '0xcafedeadbeef'
Anphabet = string.printable
cnt = 0	
str1 = iv_part1+'x'+'0'				
		
iv = str1.encode()
							
flag = decrypt(enc,key,iv)
if b'Flag' in flag:
	print(flag)
	
print(flag)
# GiongfNef

# otherway
from Crypto.Cipher import AES
from Crypto.Util.number import *
from string import printable
printable=printable.encode()
letter=b'abcdef0123456789'
c=open('cipher.txt','rb').read()
key = b'supersecretkey!?'
iv_part1 = b"0xcafedeadbeef"

def check(flag):
	tmp=flag[5:-11]
	for i in tmp:
		if bytes([i]) not in letter:
			return False
	return True
count=0
for a in letter:
	for b in letter:
		iv=iv_part1+bytes([a])+bytes([b])
		cipher=AES.new(key,AES.MODE_CBC,iv)
		flag=cipher.decrypt(c)
		if check(flag):
			print(flag)
			print(iv)
			count+=1

print(count)
# code by:lttn	

```

It's not an interesting chall, but anyway AES.MODE\_CBC is fun right ?

Thanks for reading. Have a nice day <3 .
