# Imaginary CTF 2021

 _**Note : A JOURNEY TO GAIN KNOWLEDGE**_

![source: idul n3mo &#x1F420;](https://giongfnefvblog.files.wordpress.com/2021/07/image-15.png?w=624)

Giải này mình học thêm một xíu về mảng **Misc** và **Forensics**

**\#Misc** 

**Spelling Test**

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-8.png?w=990)

file: [chall](https://github.com/rongtruong26012002/ChallFile/blob/main/Image_SpellingTest_chall.txt)

Tóm tắt: bài này cho mình một file txt có 2175 từ vựng, trong đó một số từ viết sai 1 chữ cái, mình cần tìm ra các chữ cái sai và ghép chúng lại. Đọc đến đây mình nhớ đến câu nói của vị hiền nhân nào đó "Cần lao vi tiên thủ...." . Tìm từng chữ thì chầy cối quá mình dùng thêm [proodfread](https://www.jspell.com/checker/) để hỗ trợ : D

**flag: ictf{youpassedthespellingtest}**

**Formatting** 

file: [Chall](https://github.com/rongtruong26012002/ChallFile/blob/main/ImaginaryCTF2021/Formatting_chall.py)

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-9.png?w=833)

một bài code theo oop, bài này lỗi ở [str format vulnerability](https://python-forum.io/Thread-str-format-security-vulnerability) . _**String formatting functions**_ có thể truy cập đến thuộc tính của đối tượng cũng như làm rò rỉ dữ liệu.

Tham khảo [thêm](https://www.geeksforgeeks.org/vulnerability-in-str-format-in-python/).

Mình sẽ gửi dạng {people\_obj.\_\_init\_\_.\_\_globals\_\_\[CONFIG\]\[KEY\]} cho server

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-10.png?w=866)

Mình không thể làm được bài này nếu thiếu sự giúp đỡ của ông hoàng Hướng Đối Tượng FuckAdapt, aligatooooooo \(⸝⸝ᵕᴗᵕ⸝⸝\).

**\#Forensics** 

**Vacation** 

bài này mình được bạn j1s0o cùng team chỉ cho \(🌼❛ ֊ ❛„\)![](https://giongfnefvblog.files.wordpress.com/2021/07/image-11.png?w=1024)

Chall là tìm địa điểm của hình trên dưới dạng latitude\_longitude\(vĩ độ, kinh độ\)

* ![](https://giongfnefvblog.files.wordpress.com/2021/07/image-13.png)
* ![](https://giongfnefvblog.files.wordpress.com/2021/07/image-12.png)

Quan sát 2 vị trí trên ta có thể search với key word "city of south lake tahoe hemp company"![](https://giongfnefvblog.files.wordpress.com/2021/07/image-14.png?w=1024)

**flag: ictf{38.947\_-119.961}**

**\#Crypto**

**Rock Solid Algorithm** 

```python
n = 18718668654839418101060350414897678724581774081742102287908765212690862231899547405582997157020093499506177632395430572542600019258424947803591395926472246347413986531437177801754324606200243710836609694453888894668656807471052095014376204102474311740080044776201105722801365112971807912406879483156845216746137339614577267869908065296042390812575960639865867729920434603853708907147465162697098688239587320232595412227310236678367
e = 5
c = 4061448515799106340420739691775850071489215699577921072934942485890519294380069123037340174441242842518682390853378784679825023237216051766738593812159344136064529711265570171627670665806072255545198689928996413238102114126558579154343844959868438278433954975590137693439216155482228025380904377837299357044104373966173149290333194304831238889245126840666444234215617022142380016275718234640045049962318290976661640301222078289152
```

Dạng RSA với e nhỏ nên ta dễ dàng brute force với flag = 5 √ \(k\*n + c\) với k ∈ Z

```python
from Crypto.Util.number import*

n = 18718668654839418101060350414897678724581774081742102287908765212690862231899547405582997157020093499506177632395430572542600019258424947803591395926472246347413986531437177801754324606200243710836609694453888894668656807471052095014376204102474311740080044776201105722801365112971807912406879483156845216746137339614577267869908065296042390812575960639865867729920434603853708907147465162697098688239587320232595412227310236678367
e = 5
c = 4061448515799106340420739691775850071489215699577921072934942485890519294380069123037340174441242842518682390853378784679825023237216051766738593812159344136064529711265570171627670665806072255545198689928996413238102114126558579154343844959868438278433954975590137693439216155482228025380904377837299357044104373966173149290333194304831238889245126840666444234215617022142380016275718234640045049962318290976661640301222078289152

i = 1
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
while True:
	flag = long_to_bytes(find_invpow(i*n+c,5))
	if b'ictf' in flag:
		print(flag,i)
	i+=1
#b'ictf{3_isnt_th3_0nly_sm4ll_3xp0n3nt}'
```

**flag: ictf{3\_isnt\_th3\_0nly\_sm4ll\_3xp0n3nt}**

**Flip Flops**

file: [Chall](https://github.com/rongtruong26012002/ChallFile/blob/main/ImaginaryCTF2021/FlipFlop_chall.py)

về ý tưởng : đầu tiên ta phải gửi chuỗi hex cho server, server encode mọi chuỗi trừ trường hợp có cụm 'gimmeflag', bước 2 check lại nếu trong chuỗi vừa encode có cụm 'gimmeflag' server sẽ trả lại flag. Đây là mã CBC, block đầu tiên sẽ được xor với block iv, các block sau sẽ được xor với block trước nó. Ở đây ta không kiểm soát được block đầu tiên nên bỏ qua, ta gửi cụm aaaaaaaaaaaaaaaaGimmeflag , sau khi encode xong ta đổi kí tự đầu tiên là G thành g .

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-19.png?w=1024)

Ta đổi kí tự đầu tiên cho dễ, rõ hơn:

32 = ord\('G'\) xor ord\('g'\) \( G xor g\)

ta lấy kí tự đầu tiên của chuỗi sau khi encode ở dạng hex là :

0xb7^32 \( G xor\( G xor g \)\) = g \) ta lại thu được g chuyển lại hex và thay là xong Gimmeflag -&gt; gimmeflag

**flag: ictf{fl1p\_fl0p\_b1ts\_fl1pped\_b6731f96}**

**Lines** 

file: [Chall](https://github.com/rongtruong26012002/ChallFile/blob/main/ImaginaryCTF2021/Lines.py)

bài này ta có :

flag\_enc = \(s \* flag\)%p

msg\_enc= \(s \* msg\)%p

ta dễ dàng tìm được s bằng nghịch đảo: s = \(msg^-1 \* msg\_enc \)%p tương tự ta tìm được flag .

```python
from Crypto.Util.number import *
import random

msg = bytes_to_long(b":roocursion:")
p = 82820875767540480278499859101602250644399117699549694231796720388646919033627
flag_enc = 26128737736971786465707543446495988011066430691718096828312365072463804029545
msg_enc = 15673067813634207159976639166112349879086089811595176161282638541391245739514

# s  = g^(ab) mod p
# flag_enc = (s * flag)%p
# msg_enc=(s * msg)%p

s = (pow(msg,-1,p) * msg_enc)%p 
print(s)
print(long_to_bytes((inverse(s,p) * flag_enc )%p))
```

**flag: ictf{m0d\_4r1th\_ftw\_1c963241}**

### \#**Misc** 

**Puzzle 2**

người solve: FuckAdapt

file : [chall](https://drive.google.com/drive/u/1/folders/1C5V5DiiCCgGCKGVpkOguDjVMfNYo94He)

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-16.png?w=1024)

Bài này rất thú vị, chall là một game như minecraft mình có thể di chuyển mọi nơi trong này nhưng có duy nhất một cánh cửa không mở được, đương nhiên flag nằm trong đây rồi. Về ý tưởng mình phải tìm cách "mở" cửa hoặc đi xuyên qua nó :\)

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-17.png?w=1024)

 ta có source game rồi, sử dụng dnspy thêm 1 dòng code này để tắt collision và cheat đi xuyên tường :\)\). Tham khảo [thêm](https://docs.unity3d.com/ScriptReference/Rigidbody-detectCollisions.html).

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-18.png?w=1024)

**flag: ictf{SPY\_KIDS\_ASSEMBLE}**

Bài Puzzle2 này do bạn của mình lớp cntt solve, trong một lần đi khịa dạo mình thách thằng bạn làm được bài này, ai ngờ bạn solve được thật :&gt; . Do cậu í không chơi ctf nên mình để tạm ý tưởng cậu ở đây nhó babe &lt;3 .

_Thanks for reading. Have a good day_ ٩\(๑&gt; ₃ &lt;\)۶♥

