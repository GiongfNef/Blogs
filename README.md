# Check SUMMARY.md for table of contents



# CASAWCTF 2021

**Gotta Decrypt Them All**

Bài này khi ta connect với server ta nhận đc mã Morse, khi decode mã Morse ta được bài RSA cổ điển với cipher cố định, e = 3 và N random nhưng điểm chung là rất lớn đối với c

```python
n = 122210677556715920469489888641269363693199366599255488173988172826554505844409054840356782750585839204246353553753879699378163362496336196111317791953233652238169552637885906298695803346642204941338769369532424723845873686548090743865592912214627795469389269724971994692308036391920187126382118274444019137473
e = 3
c = 152167424273977436702890273274501734012765882487008338973232502170356375148818609621863975256
```

\*Part1:

ta dễ dằng decrypt bằng 3√c, đến đây ta thấy kí tự khá quen mắt " Cbxrzba Anzrf" quăng vào rot13 ta được "Pokemon Names" tuy nhiên ta cần nhập lại server nhanh vì mỗi lần chall chỉ verify tầm 10-15s.

\*Part2:

sau khi gửi "Pokemon Names" server lại trả về mã morse tương tự, làm lại các bước ở Part1 ta sẽ được tên của một con pokemon, tiếp tục part 3,4,5... ta sẽ được các pokemon riêng biệt . Có 800+ pokemons và mỗi lần connect với server kết quả các pokemon lại khác nhau tại các part nên bỏ ngay ý định brute force. Mình viết script nhận dữ liệu từ server và respond lập tức vì mỗi lần connect server chỉ verify đúng 1 lần.

* Đầu tiên mình [decrypt mã Morse](https://www.geeksforgeeks.org/morse-code-translator-python/)
* Connect với server bằng [pwntool](https://docs.pwntools.com/en/stable/tubes.html)

```python
from pwn import * 
from Crypto.Util.number import *
import codecs
import base64
p= remote("crypto.chal.csaw.io", 5001) 

# Dictionary representing the morse code chart
MORSE_CODE_DICT = { 'A':'.-', 'B':'-...',
					'C':'-.-.', 'D':'-..', 'E':'.',
					'F':'..-.', 'G':'--.', 'H':'....',
					'I':'..', 'J':'.---', 'K':'-.-',
					'L':'.-..', 'M':'--', 'N':'-.',
					'O':'---', 'P':'.--.', 'Q':'--.-',
					'R':'.-.', 'S':'...', 'T':'-',
					'U':'..-', 'V':'...-', 'W':'.--',
					'X':'-..-', 'Y':'-.--', 'Z':'--..',
					'1':'.----', '2':'..---', '3':'...--',
					'4':'....-', '5':'.....', '6':'-....',
					'7':'--...', '8':'---..', '9':'----.',
					'0':'-----', ', ':'--..--', '.':'.-.-.-',
					'?':'..--..', '/':'-..-.', '-':'-....-',
					'(':'-.--.', ')':'-.--.-'}
 
# Function to encrypt the string
# according to the morse code chart
def encrypt(message):
	cipher = ''
	for letter in message:
		if letter != ' ':
 
			# Looks up the dictionary and adds the
			# correspponding morse code
			# along with a space to separate
			# morse codes for different characters
			cipher += MORSE_CODE_DICT[letter] + ' '
		else:
			# 1 space indicates different characters
			# and 2 indicates different words
			cipher += ' '
 
	return cipher
 
# Function to decrypt the string
# from morse to english
def decrypt(message):
 
	# extra space added at the end to access the
	# last morse code
	message += ' '
 
	decipher = ''
	citext = ''
	for letter in message:
 
		# checks for space
		if (letter != ' '):
 
			# counter to keep track of space
			i = 0
 
			# storing morse code of a single character
			citext += letter

		else:
			i += 1
			if i == 2 :
				decipher += ' '
			else:
				decipher += list(MORSE_CODE_DICT.keys())[list(MORSE_CODE_DICT
				.values()).index(citext)]
				citext = ''
 
	return decipher
def find_invpow(x,n):
	high = 1
	while high ** n < x:
		high *= 2
	low = high//2
	while low < high:
		mid = (low + high) // 2
		if low < mid and mid**n < x:
			low = mid
		elif high > mid and mid**n > x:
			high = mid
		else:
			return mid
	return mid + 1

   
 
p.recvuntil("Can you decrypt them all to prove yourself?\r\n\r\nWhat does this mean?\r\n")
message = p.recvuntil("\r\n>>",drop= True).decode("utf-8")
message = message.replace('/',' ')
result = decrypt(message)
p.sendline('Pokemon Names')

for i in range(0,5):
	p.recvuntil("What does this mean?\r\n")
	message2 = p.recvuntil("\r\n>>",drop= True).decode("utf-8")
	message2 = message2.replace('/',' ')
	result2 = decrypt(message2)
	result2 = result2.split(' ')
	result2 = result2[:-1]
	num1 = list(map(int, result2)) 
	lst = []
	for i in num1:
			lst.append(chr(i))
	mystring = "".join(lst)
	vitri = base64.b64decode(mystring)
	vitri = vitri .decode("utf-8")
	n = vitri .find("c")
	vitri = vitri [n+3:]
	vitri = int(vitri )
	key = codecs.encode(str(long_to_bytes(find_invpow(vitri ,3))), 'rot_13')
	key = key [2:-1]
	print(key)
	p.sendline(key)
p.interactive()
```

**\# flag{We're\_ALrEadY\_0N\_0uR\_waY\_7HE\_j0UrnEY\_57aR75\_70day!}**

### \#RSA Pop Quiz

Bài này có 5 part, cần connect với server như bài Gotta Decrypt Them All.

* Part1: Weiner's attack =&gt; key1: "Wiener wiener chicken dinner"
* Part2: Factorization using quadratic equation =&gt; key2: "Who came up with this math term anyway?"
* Part3: [LSB oracle \(done by bitsdeep\)](https://github.com/ashutosh1206/Crypton/tree/master/RSA-encryption/Attack-LSBit-Oracle) -&gt; ở đây mình cần viết code để connect với server

```python
from pwn import * 
from Crypto.Util.number import *

p= remote("crypto.chal.csaw.io", 5008)
p.recvuntil("What is the plaintext?")
p.sendline('Wiener wiener chicken dinner') 
p.recvuntil("What is the plaintext?")
p.sendline('Who came up with this math term anyway?') 
p.recvuntil("Part 3 --> Looks like there is a oracle which is telling the LSB of the plaintext. That will not help you, right?")

message = p.recvuntil("\r\nWhat would you like to decrypt? (please respond with an integer)\r\n",drop= True).decode('utf-8')
n = message.split('= ')
N = int(n[1][:-4])
c = int(n[3][:-2])

i = 1
flag = ""
upper_limit = N
lower_limit = 0
while i<=1030:
	s = (c*pow(2**i,65537,N))%N
	p.sendline(str(s))
	mes = p.recvuntil("\r\nWould you like to continue? (yes/no)\r\n",drop= True).decode('utf-8')
	
	if 'The oracle responds with: 1' in mes:
		lower_limit = (lower_limit + upper_limit)//2
	elif 'The oracle responds with: 0' in mes:
		upper_limit = (upper_limit + lower_limit)//2
	else:
		break
		print ("Unsuccessfull")
	print(upper_limit, i)
	p.sendline('1')
	p.recvuntil("What would you like to decrypt? (please respond with an integer)")
	i+=1
	print ("Flag : ", long_to_bytes(lower_limit))

p.interactive()
# key3: "Totally did not mean to put an oracle there"
```

* Part4: [lower half of private exponent exposed](https://github.com/p4-team/ctf/tree/master/2016-09-16-csaw/still_broken_box)

```python
from sage.all import *
from Crypto.Util.number import *

# def partial_p(p0, kbits, n):
# 	PR.<x> = PolynomialRing(Zmod(n))
# 	nbits = n.nbits()
# 	f = 2^kbits*x + p0
# 	f = f.monic()
# 	roots = f.small_roots(X=2^(nbits//2-kbits), beta=0.3)  # find root < 2^(nbits//2-kbits) with factor >= n^0.3
# 	if roots:
# 		x0 = roots[0]
# 		p = gcd(2^kbits*x0 + p0, n)
# 		return ZZ(p)

# def find_p(d0, kbits, e, n):
# 	X = var('X')
# 	for k in range(1, e+1):
# 		results = solve_mod([e*d0*X - k*X*(n-X+1) + k*n == X], 2^kbits)
# 		for x in results:
# 			p0 = ZZ(x[0])
# 			p = partial_p(p0, kbits, n)
# 			if p:
# 				return p

# if __name__ == '__main__':
# 	print ("start!")
# 	n = 92150734248055290218411802453123157352705861834384999313923627396879075182969493077863826740703500846554243898542051370243384532757106260185578330274718697752055726041920906966875591009705191340199801335272872356664545508701260930129290909057539382965530574392227266773224955362480575099934898650214757799427
# 	e = 17
# 	beta = 0.5
# 	epsilon = beta^2/7
# 	nbits = n.nbits()
# 	kbits = 300
# 	d0 = 2869307945742354237535107610373918638296750947147150756639699104312430992817216889673624219324181338287746819141271092540310416129453380803287086932038577
# 	p = find_p(d0, kbits, e, n)

N = 92150734248055290218411802453123157352705861834384999313923627396879075182969493077863826740703500846554243898542051370243384532757106260185578330274718697752055726041920906966875591009705191340199801335272872356664545508701260930129290909057539382965530574392227266773224955362480575099934898650214757799427
e = 17
d0 = 2869307945742354237535107610373918638296750947147150756639699104312430992817216889673624219324181338287746819141271092540310416129453380803287086932038577
c = 79725053860604765055702359049580728345606979823065112322272769966265784167918376912676709590218163402926694959484627983491746279513086336659328231458982039929174544843226441492936024575040726681984385693510731675993113698031139497359785845670799873466890520882908638387015600056943074248709818306204260523655
p = 7591406303201200154105438646399652141542370756810792011568309636795427994695228726553003913939362428901338363761666131812951597399245884946323348121548961
q = N// p
d = pow(e,-1,(p-1)*(q-1))
print(long_to_bytes(pow(c,d,N)))
d0bits = 512
nBits = 1024

#key4: "I'll be careful next time to not leak the key"
```

* Part5: gửi key4 cho server và ...... ra flag

**\#flag{mình\_quên\_lưu\_flag\_rồi\_mn\_tự\_tưởng\_tượng\_nhaaa}**

### \*Lời kết:

Đây là giải vui nhất mình từng chơi tính đến thời điểm hiện tại. Phần dùng pwntool connect vào server mình không biết làm từ giải hcmus, về sau cứ hễ gặp bài nào tựa vậy là quá khứ ùa về :&lt; .Mình làm được 2 bài trên do các bạn trong team hỗ trợ rất nhiều, ae chỉ từng dòng code, cỗ vũ từng phút. Đây cũng là lần đầu 4 ae cùng thức thâu đêm đến end giải. Cảm giác vui cực kì! chỉ có thể nói: Quá đãaaaaaaaaaaaaaa.

Gửi lời cảm ơn chân thành đến: @Pengu, @j1s0o, @Martin Shelby.

13 / 09 / 2021.

Cut3\_Guys in ur area

Thanks for reading. Have a good day &lt;3

