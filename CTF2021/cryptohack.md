# CryptoHack

 _**Note : A JOURNEY TO GAIN KNOWLEDGE**_

### General

**XOR Properties**

```python
import binascii
def byte_xor(ba1, ba2):
    return bytes([_a ^ _b for _a, _b in zip(ba1, ba2)])
s1 = "a6c8b6733c9b22de7bc0253266a3867df55acde8635e19c73313"
s2 = "37dcb292030faa90d07eec17e3b1c6d8daf94c35d4c9191a5e1e"
s3 = "c1545756687e7573db23aa1c3452a098b71a7fbf0fddddde5fc1"
s4 = "04ee9855208a2cd59091d04767ae47963170d1660df7f56f5faf"
s2 = bytes.fromhex(s2)
s3 = bytes.fromhex(s3)
s4 = bytes.fromhex(s4)
key1 = bytes.fromhex(s1)
key2 = b'\x91\x14\x04\xe1?\x94\x88N\xab\xbe\xc9%\x85\x12@\xa5/\xa3\x81\xdd\xb7\x97\x00\xddm\r'
key13 = b'\xf6\x88\xe5\xc4kq\xdf\xe3\x0b]F\x0b\xd7\xe3f@m\xe33\x8a\xdb\x14\xc4\xc4\x01\xdf'
k = b'g\x9c\xe1%T\xe5W\xad\xa0\xe3\x8f.R\xf1&\xe5B@\xb2Wl\x83\xc4\x19l\xd2'
a_list = byte_xor(k,s4)

print(a_list)
```

The special thing of XOR operator is when you xor with same key you can get the original message .

a ^ b = c =&gt; a = b ^ c

\(encrypt = message ^ key =&gt; message = encrypt ^ key\)

> crypto{x0r\_i5\_ass0c1at1v3}

**Favourite byte**

```python
s1 = "73626960647f6b206821204f21254f7d694f7624662065622127234f726927756d"
s1 = bytes.fromhex(s1)

def single_byte_xor(b, key) -> bytes:
    """Given a plain text `text` as bytes and an encryption key `key` as a byte
    in range [0, 256) the function encrypts the text by performing
    XOR of all the bytes and the `key` and returns the resultant.
    """
    return bytes([b ^ key for b in s1])
for c in range(256):
	if b'crypto' in single_byte_xor(s1, c):
		print(single_byte_xor(s1,c))
```

key word "a single byte" . Xor each character with integer in range \[0,256\).

> crypto{0x10\_15\_my\_f4v0ur173\_by7e}

**You either know, XOR you don't**

```python
encrypt = "0e0b213f26041e480b26217f27342e175d0e070a3c5b103e2526217f27342e175d0e077e263451150104"
encrypt = bytes.fromhex(encrypt)
key_form = b'crypto{'

key = [s1 ^ s2 for (s1, s2) in zip(encrypt, key_form)] + [ord("y")]


flag = []
for i in range(len(encrypt)):
    flag.append(encrypt[i] ^ key[i%len(key)])
for c in flag:
    print(chr(c), end ="")
```

Idea: Find key by xor encrypt message and key\_form then xor key with encrypt.

> crypto{1f\_y0u\_Kn0w\_En0uGH\_y0u\_Kn0w\_1t\_4ll}

**Lemur XOR**

What do you think about Adobe?

![](https://giongfnefvblog.files.wordpress.com/2021/07/image.png?w=1024)

Adobe Photoshop why not ? :&gt;

> crypto{X0Rly\_n0t ? }

 Thanks for reading. Have a good day &lt;3

