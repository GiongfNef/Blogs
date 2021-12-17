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

### #Cry more

```
import datetime
import os
import random
import socketserver
import sys
from base64 import b64decode, b64encode
from hashlib import sha512


def get_flag():
    try:
        with open('flag.txt', 'rb') as f:
            flag = f.read()
            return flag
    except Exception as e:
        print(e)
        return b'Server is not configured correctly. Please contact admins to fix the problem'


items = [
    (b'Fowl x 3', 1),
    (b'Mora x 30000', 100),
    (b'Mystic Enhancement Ore x 5', 500),
    (b'Hero\'s Wits x 3', 1000),
    (b'Primogems x 40', 5000),
    (b'FLAG', 99999)
]


class RequestHandler(socketserver.StreamRequestHandler):

    def handle(self):
        self.signkey = os.urandom(random.randint(8, 32))
        self.money = random.randint(1, 2000)
        try:
            while True:
                self.menu()

                try:
                    self.request.sendall(b'Your choice: ')
                    opt = int(self.rfile.readline().decode())
                except ValueError:
                    self.request.sendall(
                        b'THIS IS A CRYPTOGRAPHIC CHALLENGE!!!\n')
                    continue
                if opt == 1:
                    self.list()
                elif opt == 2:
                    self.order()
                elif opt == 3:
                    self.confirm()
                elif opt == 4:
                    self.request.sendall(b'Bye~\n')
                    return
                else:
                    self.request.sendall(b'Ohh~\n')

        except (ConnectionResetError, ConnectionAbortedError, BrokenPipeError):
            print("{} disconnected".format(self.client_address[0]))

    def menu(self):
        self.request.sendall(
            b'To celebrate `our` first anniversary, we are offering you tons of product at the best prices\n')
        self.request.sendall(b'You have $%d\n' % self.money)
        self.request.sendall(b'1. Available products\n')
        self.request.sendall(b'2. Order\n')
        self.request.sendall(b'3. Confirm order\n')
        self.request.sendall(b'4. Exit\n')

    def list(self):
        for idx, item in enumerate(items):
            self.request.sendall(b'%d - %s: $%d\n' %
                                 (idx + 1, item[0], item[1]))

    def order(self):
        try:
            self.request.sendall(b'ID: ')
            pid = int(self.rfile.readline().decode())
        except ValueError:
            self.request.sendall(
                b'THIS IS A CRYPTOGRAPHIC CHALLENGE!!!\n')
            return

        if pid < 1 or pid > len(items):
            self.request.sendall(b'Ohh~\n')
            return

        payment = b'product=%s&price=%d&time=%.02f' % (items[pid-1][0], items[pid-1][1], datetime.datetime.now().timestamp())
        signature = sha512(self.signkey+payment).hexdigest()
        payment += b'&sign=%s' % signature.encode()
        self.request.sendall(b'Your order: ')
        self.request.sendall(b64encode(payment))
        self.request.sendall(b'\n')

    def confirm(self):
        try:
            self.request.sendall(b'Your order: ')
            payment = b64decode(self.rfile.readline().rstrip(b'\n'))
        except Exception:
            self.request.sendall(
                b'THIS IS A CRYPTOGRAPHIC CHALLENGE!!!\n')
            return

        pos = payment.rfind(b'&sign=')
        if pos == -1:
            self.request.sendall(b'Invalid order\n')
            return

        signature = payment[pos + 6:]
        if sha512(self.signkey+payment[:pos]).hexdigest().encode() != signature:
            self.request.sendall(b'Invalid order\n')
            return

        m = self.parse_qsl(payment[:pos])
        try:
            pname = m[b'product']
            price = int(m[b'price'])
        except (KeyError, ValueError, IndexError):
            self.request.sendall(b'Invalid order\n')
            return

        if price > self.money:
            self.request.sendall(b'Oops\n')
            return

        self.money -= price
        self.request.sendall(
            b'Transaction is completed. Your balance: $%d\n' % self.money)
        if pname == b'FLAG':
            print("{} solved the challenge".format(self.client_address[0]))
            self.request.sendall(b'Here is your flag: %s\n' % get_flag())
        else:
            self.request.sendall(
                b'%s will be delivered to your in-game mailbox soon\n' % pname)

    def parse_qsl(self, query):
        m = {}
        parts = query.split(b'&')
        for part in parts:
            key, val = part.split(b'=')
            m[key] = val
        return m


class ThreadedTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


def main(argv):
    host, port = 'localhost', 8000

    if len(argv) == 2:
        port = int(argv[1])
    elif len(argv) >= 3:
        host, port = argv[1], int(argv[2])

    sys.stderr.write('Listening {}:{}\n'.format(host, port))
    server = ThreadedTCPServer((host, port), RequestHandler)
    server.daemon_threads = True
    server.allow_reuse_address = True
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    server.server_close()


if __name__ == '__main__':
    main(sys.argv)
```



Đọc code thấy rõ ta cần có cụm 'product=FLAG' có đủ tiền và đúng signature để có đươc flag. Ở đây ta dùng [hash\_extender](https://github.com/iagox86/hash\_extender) để hỗ trợ thêm cụm '\&product=FLAG' vào newstring sau đó thêm cụm '\&sign=' cùng với signature mới



Thanks for reading. Have a nice day <3 .
