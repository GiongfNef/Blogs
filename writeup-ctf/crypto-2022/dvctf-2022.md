---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
cover: ../../.gitbook/assets/7c53bda77091dfa2535e5a276a0e0571.jpg
coverY: 0
---

# dvCTF 2022

## #Intro

![](<../../.gitbook/assets/image (7) (1) (1).png>)

* [x] Đây là giải đầu tiên trong năm 2022 mình nghiêm túc dành thời gian nghiên cứu.
* [x] Mình học được thêm một số kiến thức rất thú vị nên muốn note lại cũng như chia sẻ năng lượng tích cực này đến với mọi người.

## #small weiner

![](<../../.gitbook/assets/image (13) (1) (1) (1).png>)

```
m = 0x596f7520686176652073756368206120736d616c6c207765696e65722e2049204841544520594f5521212121
N = 0x26553fbb7e4bd5bd48868a25f24d9cc5975aa8597f82110058e687dfa10dd0114c0d2011fa288dbd9d01c0a70dfa8212d5a218d513bdd8ebed9f75bc299e1461be8a23ed8ade96bc449d409fbbf5a328ee2ad3257e6c55a97641258730f74f4d3938f0df794546791ba2b1518b8d855e83f65f885d67aa000a01687ac605404e7bca681e51e6e195f77eb4785fcda0372e3d0fd90240f736243584677f89da4c6ab54d687897d5afb0801cc151c516b072aaa2d9aa8d39d34c230536cba077beaa88ff8e8940a5ba990cafd0b1326f209873a43a785d0c5477241fb6469b8c27c7d54908467a7525de18b2425901c0de3ed63472831c29818ce6efb0354c61f36b2e61146472e99209d198bc885ced0edb66eab62a968c9b98b49b756c689d69820ca1d97e1232c338084097078265ce79b25c1e37bc777247af3fee2ce7a87a697a120c0428327177cf6e934aa2d18e696474227d361a5c36992788c3b1aa8654b88852e897027d58b21576b25a5ffdcb9fbdc5167eb74f1c9082ae79ca0b89
e = 0xfc2e4d12eb69a42c074d9a0ddc6b84294f1e23d6eaa0ba53e9cb60ec0db203d31bdfb90eaca38189890ad26335ad6107cd234a415bfc73fc1bbd6c5d9da65249eebb57d889f91719cfdbd535ab19d2d317ffdf075870a62c6e05aac16c9b122e1c52d7dbeb2fb683514d0f463b58a4217f2e379e5a62be06e764e043a0eac5ac6af56816af926bcc4cd826ee1cfd4157496dc024042676503cec93de45c3c5e4dd9dcf85406a3cf93a9f784b9eef6e320cd9856aefff48df52127b98da8a0d207f588ce1c58e47419554590b1fa7fa3c38034f93a3a5112b6dd5e78c181abc2d972fbcb058575789c68c03f043bd4bf48d94fa7390c77f9fc033f3f01a5162d31056eb42a07397f3485b25396f93558466fc49ef80adea1e9d6c3d9edf529be5faf014669ae5f8e02433a2474d9c92fcc468d81aa0fd641a5647d55153713783a9e5d66fe70c9c2794325b28f20b751fb49359c4a8487bbfa7efc6270b7fa0ffe277276bba14027596d129fcbdef0a82aba24855bfd2155071b52c11da2d943
```

Workflow:

* Thoạt nhìn ta thấy rõ [`weiner`](https://en.wikipedia.org/wiki/Wiener's\_attack) mình nghĩ ngay đến weiner attack tuy nhiên nó lại không hoạt động, vậy có thể d > 1/3 N^0.25.
* Lúc này mình nghĩ đến một biến thể khác của weiner là [`Boneh–Durfee`](https://github.com/mimoo/RSA-and-LLL-attacks/blob/master/boneh\_durfee.sage), dùng denta = 0.292 tuy nhiên cũng không đến đâu.
* Tới đây mình phân tích lại đề bài: public key đều lớn và mình biết luôn cả plaintext, tên của bài lại liên quan đến weiner nên có thể là rút gọn không gian latice 2 chiều&#x20;

> Vì điều kiện  d > 1/3 N^0.25 có thể chống Wiener attack tuy nhiên nếu d rất nhỏ thì ta vẫn có thể khôi phục được lại d

Ý tưởng mình tham khảo từ [`Low-Dimensional Attacks`](https://www.di.ens.fr/\~pnguyen/PubSantanderNotes.pdf) (trang 34-35) và lý thuyết Lattices trong sách [`An Introduction to Mathematical Cryptography`](https://people.ucsc.edu/\~morozco7/Books/hoffstein2014introduction.pdf)(chương 7,trang 405-406).

Tóm tắt :&#x20;

\*Một chút toán học

Giả sử ta có L ⊂ R2 be the lattice, với 2 vecto: v1 = (137, 312) và v2 = (215, −187).

Giả định có 2 phương trình tuyến tính:

* 53172 = 137\*t1 + 215\*t2
* 81743 = 312\*t1 − 187\*t2

Dạng ma trận như sau:![](<../../.gitbook/assets/image (29) (1) (1) (1).png>)  thường thì ta dễ dàng tính được t1,t2 bằng ma trận nghịch đảo. Ngược lại, [`Babai’s algorithm`](http://www.noahsd.com/mini\_lattices/05\_\_babai.pdf) giúp ta tìm t1,t2 gần đúng từ đó có thể tìm lại vecto v.

![](<../../.gitbook/assets/image (21) (1).png>)

Vậy nó liên quan gì đến challenge trên ?

* Bởi vì p và q cân bằng nhau nên ta có thể viết ![](<../../.gitbook/assets/image (9) (1).png>)
* Public exponent được chọn có gần như cùng kích cỡ với φ(N) nên k gần như cùng kích cỡ với d, ta có thể viết:  k = O(d)

Từ đó:

> ed = 1 + k\*φ(N)  <=>   ed =1 + k( N + O(√N) )  <=>   ed − k\*N = O(d√N)

Viết dưới dạng ma trận: ![](<../../.gitbook/assets/image (17) (1).png>)

Lúc này d\*(e, sqrt(N)) + k\*(N, 0) = (ed_+k_N, d\*sqrt(N))

như vậy vector v =( ed − kN, d√N ) là [<mark style="color:blue;">`a short vector of the lattice`</mark>](https://en.wikipedia.org/wiki/Lattice\_problem), đến đây dùng thuật toán [`Gaussian Reduction`](https://www.codesansar.com/numerical-methods/gauss-elimination-method-python-program.htm) hoặc [<mark style="color:blue;">`LLL`</mark>](https://cims.nyu.edu/\~regev/teaching/lattices\_fall\_2004/ln/lll.pdf) <mark style="color:blue;"></mark> để tìm vecto v từ đó tính được d.

solve của mình:

```
# sagemath
m = 0x596f7520686176652073756368206120736d616c6c207765696e65722e2049204841544520594f5521212121
N = 0x26553fbb7e4bd5bd48868a25f24d9cc5975aa8597f82110058e687dfa10dd0114c0d2011fa288dbd9d01c0a70dfa8212d5a218d513bdd8ebed9f75bc299e1461be8a23ed8ade96bc449d409fbbf5a328ee2ad3257e6c55a97641258730f74f4d3938f0df794546791ba2b1518b8d855e83f65f885d67aa000a01687ac605404e7bca681e51e6e195f77eb4785fcda0372e3d0fd90240f736243584677f89da4c6ab54d687897d5afb0801cc151c516b072aaa2d9aa8d39d34c230536cba077beaa88ff8e8940a5ba990cafd0b1326f209873a43a785d0c5477241fb6469b8c27c7d54908467a7525de18b2425901c0de3ed63472831c29818ce6efb0354c61f36b2e61146472e99209d198bc885ced0edb66eab62a968c9b98b49b756c689d69820ca1d97e1232c338084097078265ce79b25c1e37bc777247af3fee2ce7a87a697a120c0428327177cf6e934aa2d18e696474227d361a5c36992788c3b1aa8654b88852e897027d58b21576b25a5ffdcb9fbdc5167eb74f1c9082ae79ca0b89
e = 0xfc2e4d12eb69a42c074d9a0ddc6b84294f1e23d6eaa0ba53e9cb60ec0db203d31bdfb90eaca38189890ad26335ad6107cd234a415bfc73fc1bbd6c5d9da65249eebb57d889f91719cfdbd535ab19d2d317ffdf075870a62c6e05aac16c9b122e1c52d7dbeb2fb683514d0f463b58a4217f2e379e5a62be06e764e043a0eac5ac6af56816af926bcc4cd826ee1cfd4157496dc024042676503cec93de45c3c5e4dd9dcf85406a3cf93a9f784b9eef6e320cd9856aefff48df52127b98da8a0d207f588ce1c58e47419554590b1fa7fa3c38034f93a3a5112b6dd5e78c181abc2d972fbcb058575789c68c03f043bd4bf48d94fa7390c77f9fc033f3f01a5162d31056eb42a07397f3485b25396f93558466fc49ef80adea1e9d6c3d9edf529be5faf014669ae5f8e02433a2474d9c92fcc468d81aa0fd641a5647d55153713783a9e5d66fe70c9c2794325b28f20b751fb49359c4a8487bbfa7efc6270b7fa0ffe277276bba14027596d129fcbdef0a82aba24855bfd2155071b52c11da2d943
c = pow(m,e,N)
s = floor(sqrt(N))
M = Matrix([[e, s], [N, 0]])
vector= M.LLL()
D = [abs(vector[i, 1]) // s for i in [0,1]]
for d in D:
    if pow(c,d,N) == m:
        print(d)
# dvCTF{79070855007994582698354011721316587208400326157509581241514418985973605934731}
```

## #Secure Or Not Secure

![](<../../.gitbook/assets/image (19) (1) (1).png>)

demo:

* Cơ bản là khi register nhập username và password ta sẽ được một cookie&#x20;
* username tối da 8 kí tự, password  tối đa 16 kí tự
* Login đúng cookie sẽ có flag&#x20;

![](<../../.gitbook/assets/image (25) (1) (1).png>)

Quan sát:

* Khi login server trả về plaintext của cookie và ta thấy cụm ;admin=False; có vẻ khi đúng username và password thì admin role sẽ đổi thành True ... hoặc mình tự đổi nó lại :)))
* Decode base64 không có nghĩa, có thể là dùng thuật toán nào đó hoặc xor với chuỗi gì đó để mình không decode được
* Mình cần làm cách nào đó để đổi role admin là được nhưng lại không biết nó là cipher gì, một cách quen thuộc có thể là phép xor chăng ?

> Về ý tưởng phép xor: a xor b = c <=> a xor c = b
>
> Từ đó mình lấy 'admin=False' xor với đoạn cookie tương ứng để lấy key rồi dùng key đó để xor lại 'admin=True' được đoạn cookie mới, nối lại rồi login thôi.&#x20;
>
> Tuy nhiên nếu chỉ lấy cụm 'admin=False' thì khi nối lại sẽ dẫn đến kết quả sai bởi lẽ chiều dài của False là 5 trong khi True là 4.
>
> Vì vậy mình lấy từ đoạn admin=False đến hết chuỗi rồi xor với đoạn cookie tương ứng

Đoạn script nhỏ của mình:

```
import base64

def xor(var, key):
        return bytes(a ^ b for a, b in zip(var, key))

cookie = 'cbCVPcNz4b9mfY8sFPIjV0AzXYy1UuuF9Kmzf7w7a6/j6ZsHVLndCeaQ9tGTeU61o1GKk7+llQ=='
enc = base64.b64decode(cookie)
plain = b'username=\x00\x00\x00\x00\x00\x00\x00\x00;admin=False;password=\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
a = b'admin=False;password=\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
b = b'admin=True;password=\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
c = enc[18:] #18 là vị trí admin tương ứng trong enc
key = xor(a,c)
tmp = xor(b,key)

print(base64.b64encode(enc[:18]+ tmp ))
#b'cbCVPcNz4b9mfY8sFPIjV0AzXYy1UuuF5rqqaeJwer3j7YMaQuDgCeaQ9tGTeU61o1GKk7+l'
```

Có cookie fake rồi mình login thử xem

![](<../../.gitbook/assets/image (5) (1) (1).png>)

## #Cwyptographic Owacle

![](<../../.gitbook/assets/image (11) (1) (1).png>)

source:

```
import ecdsa
import random
import hashlib
import time
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Util.number import long_to_bytes

FLAG = b'dvCTF{XXXXXXXXXXXXXXXXXXX}'

def encrypt_flag(priv):
    key = long_to_bytes(priv)
    cipher = AES.new(key, AES.MODE_ECB)
    text = cipher.encrypt(pad(FLAG, 16))
    print(text.hex())
>> cipher1 = AES.new(key, AES.MODE_CBC, iv)
>>> ct = cipher1.encrypt(pad(data, 16))
m = 0

print("Hiii ~~ Pwease feel fwee to use my sooper dooper cwyptographic owacle! ~~~~~~")
while True:

	print("[1] > Sign your own message ≧◡≦")
	print("[2] > Get the signed flag uwu ~~ ")
	print("[3] > Quit (pwease don't leave me)")
	try:
		n = int(input())
		if n<0 or n>3:
			raise
	except:
		print("Nice try ಥ_ಥ")
		exit(1)
	if n==1:
		msg = input("What's your message senpai? (●´ω｀●) > ")
		G = ecdsa.NIST256p.generator
		order = G.order()
		priv = random.randrange(1,order)
		Public_key = ecdsa.ecdsa.Public_key(G, G * priv)
		Private_key = ecdsa.ecdsa.Private_key(Public_key, priv)
		
		k = random.randrange(1, 2**128) if m==0 else int(time.time())*m

		m = int(hashlib.sha256(msg.encode()).hexdigest(),base=16)

		sig = Private_key.sign(m, k)

		print (f"Signature (r,s): ({sig.r},{sig.s})")
	elif n==2:
		if m==0:
			G = ecdsa.NIST256p.generator
			order = G.order()
			priv = random.randrange(1,order)
		encrypt_flag(priv)

	else:
		print("Cya (◕︵◕) ")
		exit(1)
```

demo:&#x20;

![](<../../.gitbook/assets/image (34) (1) (1).png>)

Sau khi đọc code và demo:

* Mấu chốt của bài này là tìm key để decrypt AES, key lúc này chính là priv
* priv sẽ được random vào mỗi lần connect sau đó tạo public key và private key&#x20;
* Đây là dạng chữ kí số ecdsa, sau khi nhập input ta nhận lại được Signature (r,s)

```
G = ecdsa.NIST256p.generator
order = G.order()
priv = random.randrange(1,order)
Public_key = ecdsa.ecdsa.Public_key(G, G * priv)
Private_key = ecdsa.ecdsa.Private_key(Public_key, priv)
```

* Đáng chú ý là cần có message và số k để sign

```
k = random.randrange(1, 2**128) if m==0 else int(time.time())*m

m = int(hashlib.sha256(msg.encode()).hexdigest(),base=16)

sig = Private_key.sign(m, k)

print (f"Signature (r,s): ({sig.r},{sig.s})")
```

* Mình sign thử 2 lần thì thấy r có giá trị khác nhau nên không thể là [<mark style="color:blue;">`ECDSA Nonces Reused`</mark>](https://billatnapier.medium.com/ecdsa-weakness-where-nonces-are-reused-2be63856a01a)
* Đến đây mình để ý m sẽ không đổi mà phụ thuộc vào input trước đó mình nhập vào và k có khả năng tìm được.
* Khi có m và k mình hoàn toàn có thể tìm lại private\_key từ đó tìm lại priv bằng [<mark style="color:blue;">`A Single Random Nonce`</mark>](https://medium.com/asecuritysite-when-bob-met-alice/cracking-ecdsa-with-a-leak-of-the-random-nonce-d72c67f201cd)<mark style="color:blue;">``</mark>

Ý tưởng ban đầu là vậy, workflow lúc mình làm:

* m đã có, vấn đề còn lại là k, lần sign đầu tiên k sẽ random trong khoảng (1, 2\*\*128)
* Ý tưởng ban đầu mình brute force thử k thì thấy hoàn toàn không khả thi, không gian quá lớn trong khi máy mình quá si đa
* Lúc này mình xét tới vế else ở sau tức là lần sign thứ 2 trở đi, `k = int(time.time())*m` chính bằng giá trị thời gian lúc đó nhân với giá trị m
* &#x20;Có vẻ khả thi ! Mình dùng pwntool giao tiếp trực tiếp với server nhằm lấy chính xác giá trị `time.time()` lúc khởi tạo

> Tuy nhiên, đến cuối mình vẫn không ra kết quả như ý :((( . Mấu chốt chính là hàm                        `int(time.time())`, dù đã sử dụng giá trị tại thời điểm khởi tạo nhưng nó vẫn có thể sai vài giây. Đến đây mình cần brute force k một chút, `int(time.time()+i)*m` hoặc `int(time.time()-i)*m` i ở đây là vài giây gì đó

solution của mình:

```
import ecdsa
import random
import libnum
import hashlib
import sys
import time
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad,unpad
from Crypto.Util.number import long_to_bytes
from pwn import *
# connect server
p = remote('challs.dvc.tf', 2601)

m = int(hashlib.sha256('a'.encode()).hexdigest(),base=16)
G = ecdsa.NIST256p.generator
order = G.order()

def decrypt_flag(priv,enc):
    key = long_to_bytes(priv)
    enc = bytes.fromhex(enc)
    print(enc)
    cipher = AES.new(key, AES.MODE_ECB)
    flag = unpad(cipher.decrypt(enc),16)
    return flag

# sign lần đầu
p.sendlineafter(b"[3] > Quit (pwease don't leave me)", b'1')
p.sendline(b'a')

# sign lần 2
p.sendlineafter(b"[3] > Quit (pwease don't leave me)", b'1')
p.sendline(b'a')
k = int(time.time())*m

p.recvuntil(b'\r\n')
p.recvuntil(b"What's your message senpai? (\xe2\x97\x8f\xc2\xb4\xcf\x89\xef\xbd\x80\xe2\x97\x8f) > ")
p.recvuntil(b"Signature (r,s): (")

# Nhận r,s và encrypt_flag ở lần sign thứ 2
r = p.recvuntil(b',', drop = True)
s = p.recvuntil(b')\r\n', drop = True)
p.sendline(b'2')
p.recvuntil(b"[1] > Sign your own message \xe2\x89\xa7\xe2\x97\xa1\xe2\x89\xa6\r\n[2] > Get the signed flag uwu ~~ \r\n[3] > Quit (pwease don't leave me)\r\n")

enc = p.recvuntil(b'\r\n', drop = True)
r = int(r.decode('utf-8'))
s = int(s.decode('utf-8'))
enc = enc.decode('utf-8')
# print(r,s)
# print(enc)

# Brute force giá trị của k lưu vào mảng, có thể chênh lệch vài giây gì đó
maybekey = [] 
for i in range(10):
    a = int(time.time()-i)*m
    maybekey.append(a)
    b = int(time.time()+i)*m
    maybekey.append(b)
print(maybekey)

# kết hợp k,m tìm lại priv rồi decrypt AES.MODE_ECB  
r_inv = libnum.invmod(r, order)
for i in maybekey:
	try_private_key = (r_inv * ((i * s) - m)) % order
	try:
		flag = decrypt_flag(try_private_key,enc)
		print(flag)
	except:
		print("None")
# dvCTF{y0u_h4v3_500p32_d00p32_c2yp70_5kill5_uwu}
```

Lời cuối:&#x20;

* Giải này rất thú vị, ở chall cuối mình thức trắng 1 đêm để tìm hiểu và cảm thấy nó rất đáng.
* Mình xin gửi lời cảm ơn chân thành nhất đến các ac team B1T5, các ac rất nhiệt nên mình không thể 'nguội' được :smile:. Cảm ơn cả những người ae đã hổ trợ mình phần code bài cuối.
* Cảm ơn cả sư phụ nữa hehe.

> Hết ùi, cảm ơn mọi người đã đọc.

Thanks for reading. Have a good day :heart: !



Contact:

* <mark style="color:blue;">``</mark><img src="../../.gitbook/assets/image (6) (1).png" alt="" data-size="line"><mark style="color:blue;"></mark>[<mark style="color:blue;">facebook</mark> ](https://www.facebook.com/rong.truong.372)<mark style="color:blue;"></mark>
