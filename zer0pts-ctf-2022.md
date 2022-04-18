---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🐥 zer0pts CTF 2022

### #Anti-Fermat

source:

```
from Crypto.Util.number import isPrime, getStrongPrime
from gmpy import next_prime
from secret import flag

# Anti-Fermat Key Generation
p = getStrongPrime(1024)
q = next_prime(p ^ ((1<<1024)-1))
n = p * q
e = 65537

# Encryption
m = int.from_bytes(flag, 'big')
assert m < nbin
c = pow(m, e, n)

print('n = {}'.format(hex(n)))
print('c = {}'.format(hex(c)))

```

output:

```
n = 0x1ffc7dc6b9667b0dcd00d6ae92fb34ed0f3d84285364c73fbf6a572c9081931be0b0610464152de7e0468ca7452c738611656f1f9217a944e64ca2b3a89d889ffc06e6503cfec3ccb491e9b6176ec468687bf4763c6591f89e750bf1e4f9d6855752c19de4289d1a7cea33b077bdcda3c84f6f3762dc9d96d2853f94cc688b3c9d8e67386a147524a2b23b1092f0be1aa286f2aa13aafba62604435acbaa79f4e53dea93ae8a22655287f4d2fa95269877991c57da6fdeeb3d46270cd69b6bfa537bfd14c926cf39b94d0f06228313d21ec6be2311f526e6515069dbb1b06fe3cf1f62c0962da2bc98fa4808c201e4efe7a252f9f823e710d6ad2fb974949751
c = 0x60160bfed79384048d0d46b807322e65c037fa90fac9fd08b512a3931b6dca2a745443a9b90de2fa47aaf8a250287e34563e6b1a6761dc0ccb99cb9d67ae1c9f49699651eafb71a74b097fc0def77cf287010f1e7bd614dccfb411cdccbb84c60830e515c05481769bd95e656d839337d430db66abcd3a869c6348616b78d06eb903f8abd121c851696bd4cb2a1a40a07eea17c4e33c6a1beafb79d881d595472ab6ce3c61d6d62c4ef6fa8903149435c844a3fab9286d212da72b2548f087e37105f4657d5a946afd12b1822ceb99c3b407bb40e21163c1466d116d67c16a2a3a79e5cc9d1f6a1054d6be6731e3cd19abbd9e9b23309f87bfe51a822410a62
```

Để ý:

* q = next\_prime(p ^ ((1<<1024)-1)) lúc này chính là giá trị prime kế tiếp của p xor pow(2,1024) -1
* Điều thú vị ở đây pow(2,1024) -1 ở dạng binary chính là một dãy 0b1111...1111 khi xor với p chính là lật lại bit của p.
* Ví dụ a=0b11110000 khi và  b = 0b11111111 thì c = a xor b = 0b00001111 hay viết lại giá trị          b = a+c

Ý tưởng khai thác:

* Chi tiết trên ta có thể viết lại như sau: p + q'=(2\*\*1024)-1 và p \* q = n với q' lúc này là prime trước đó của q.
* Khi thử mô phỏng lại mình thấy giá trị khoảng cách giữa q và q' không quá lớn => có thể brute force được .
* Như vậy lúc này ta có: p \* q = n và p + (q-i) = (2\*\*1024)-1 với i là giá trị brute force từ đó tìm được p, q.

solve:

```
from Crypto.Util.number import *
import gmpy2 
n = 0x1ffc7dc6b9667b0dcd00d6ae92fb34ed0f3d84285364c73fbf6a572c9081931be0b0610464152de7e0468ca7452c738611656f1f9217a944e64ca2b3a89d889ffc06e6503cfec3ccb491e9b6176ec468687bf4763c6591f89e750bf1e4f9d6855752c19de4289d1a7cea33b077bdcda3c84f6f3762dc9d96d2853f94cc688b3c9d8e67386a147524a2b23b1092f0be1aa286f2aa13aafba62604435acbaa79f4e53dea93ae8a22655287f4d2fa95269877991c57da6fdeeb3d46270cd69b6bfa537bfd14c926cf39b94d0f06228313d21ec6be2311f526e6515069dbb1b06fe3cf1f62c0962da2bc98fa4808c201e4efe7a252f9f823e710d6ad2fb974949751
c = 0x60160bfed79384048d0d46b807322e65c037fa90fac9fd08b512a3931b6dca2a745443a9b90de2fa47aaf8a250287e34563e6b1a6761dc0ccb99cb9d67ae1c9f49699651eafb71a74b097fc0def77cf287010f1e7bd614dccfb411cdccbb84c60830e515c05481769bd95e656d839337d430db66abcd3a869c6348616b78d06eb903f8abd121c851696bd4cb2a1a40a07eea17c4e33c6a1beafb79d881d595472ab6ce3c61d6d62c4ef6fa8903149435c844a3fab9286d212da72b2548f087e37105f4657d5a946afd12b1822ceb99c3b407bb40e21163c1466d116d67c16a2a3a79e5cc9d1f6a1054d6be6731e3cd19abbd9e9b23309f87bfe51a822410a62

i = 0
# while True:
#     b = 2**1024 + i
#     d = (b**2) - (4*n) 
#     if (d>=0):
#         p1 = (-b-gmpy2.iroot(d,2)[0])//(2)  
#         p2 = (-b+gmpy2.iroot(d,2)[0])//(2)  
#         q1 = n//p1
#         q2 = n//p2
#         if(p1*q1 == n | p2*q2 ==n):
#             print(p1, q1)
#             print(p2, q2)
#             break       
#     print(i)
#     i+=1
e =65537
p = 26312996731030334316852870398609068810266516659273667030650981383846505612942699907954569655874628551806159440082014957872158219466716148004273413316610854172084542519306657353734384646619184859689459846552337097703218563404822479846236196955320745061192948994907880082083502941103748624859531452917595165959 
q= 153456316755201256456077648680293404551531181234956990242779099773886170192558263224753907666532907469313954439789378399786631549347700474488574017322863270205683350905558827922567834954626909259763623105532668671134932118937640401627676913585506492102157561689678418157863742997375967679975824876706628973287
phi = (p-1)*(q-1)
d= pow(e,-1,phi)
print(long_to_bytes(pow(c,d,n)))
```

> Good job! Here is the flag:\n+-----------------------------------------------------------+\n| zer0pts{F3rm4t,y0ur\_m3th0d\_n0\_l0ng3r\_w0rks.y0u\_4r3\_f1r3d} |\n+-----------------------------------------------------------+

Thanks for reading. Have a good day :heart: !



Contact:

* <mark style="color:blue;">``</mark><img src=".gitbook/assets/image (6).png" alt="" data-size="line"><mark style="color:blue;">``</mark>[<mark style="color:blue;">`facebook`</mark> ](https://www.facebook.com/rong.truong.372)<mark style="color:blue;">``</mark>
