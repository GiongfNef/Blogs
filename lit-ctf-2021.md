# LIT CTF 2021

 _**Note : A JOURNEY TO GAIN KNOWLEDGE**_

**crypto/7 More Caesar Salads**

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-5.png?w=880)

> flag{Welcome\_To\_Cryptography}

**crypto/Zzz**

[Đề](https://github.com/rongtruong26012002/ChallFile/blob/main/crypto/Zzz_Chall.txt) mình để ở đây

Về cơ bản thử qua "frequency analysis", rồi "substitute cipher" không thì quăng thẳng vô [quipqiup](https://quipqiup.com/) .

> flag{HOW\_DO\_YOU\_KNOW\_YOU\_ARE\_NOT\_SLEEPING}

**crypto/RSA Improved**

[Đề](https://github.com/rongtruong26012002/ChallFile/blob/main/crypto/crypto/RSA%20Improved_chall.py) mình để ở đây

Thường thì phi = \(p-1\)\(q-1\) \(với q,p là số nguyên tố\)

Hiểu sâu hơn một tí thì số nguyên tố là trường hợp hơi đặc biệt xíu của Euler's totient , số nguyên tố có euler bằng chính số đó trừ 1 . Nếu factor ra tích của nhiều số nguyên tố, ta chỉ việc lấy các SNT trừ 1 rồi nhân lại. Mau hơn thì [factor ](https://www.alpertron.com.ar/ECM.HTM) lấy Euler's totient từ đây luôn.

[Solve](https://github.com/rongtruong26012002/SolveFile/blob/main/crypto/LIT_RSA%20Improved_solve.py) của mình.

> flag{rsa\_1s\_4\_pr3tty\_imp0rt4nt\_crypt0\_4lg0r1thm}

**crypto/Geometry is Fun!**

Đề là hình khá thú vị

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-1.png?w=1024)

về ý tưởng : ta tính thử diện tích các hình trên

![](https://giongfnefvblog.files.wordpress.com/2021/07/image-3.png?w=974)

Quan sát một xíu thì đó là kí tự trong Alphabet, điền đúng form là xong

```text
# flag{I_LOVE_GEO}
# flag{i_love_geo}
# flag{1_l0v3_g30}
# flag{I_Love_Geo}
# flag{i_love_GEO}
# flag{i_love_GEOMETRY}
# flag{i_love_geometry}
# flag{1_L0V3_G30M3TRY}
# flag{I_LOVE_GEOMETRY}
# flag{I_love_GEOMETRY}
# flag{I_Love_Geometry}
```

Dành cả ngày để mò cho đúng form, nhưng không đây mới là flag :\)

> flag{ilovegeo}

**crypto/Scottish Flag**

 [Đề](https://github.com/rongtruong26012002/ChallFile/blob/main/LIT_Scottish%20Flag_chall.py) mình để ở đây

Về cơ bản, mình có 3 phương trình 3 ẩn dễ dàng để giải nhưng ở đây mình cần tìm ct0 và ct1 thôi nên thay một xíu là ra. Vấn đề chỉ nằm ở việc khi tính sqrt mình dùng sage vì python sqrt dạng float, chuyển kiểu dữ liệu về int sẽ gây sai số dẫn đến sai đoạn sau của flag \( flag{6t............  \)

[Solve](https://github.com/rongtruong26012002/SolveFile/blob/main/solve_crypto/solve_Scottish%20Flag.sage) của mình

> flag{6r1t15h\_cr0s5\_mak35\_g00d\_pro6I3m}

**Leftovers**

Bài này do anh lttn làm, mình có tham khảo anh khi giải kết thúc. Do ảnh không viết Wu lần này nên mình mạn phép để ở đây sau này đọc lại.

[Đề](https://github.com/rongtruong26012002/ChallFile/blob/main/LIT_Leftovers_chall.py)

source khá giống bài **crypto/Scottish Flag** . Có seed của random, sẽ biết đc sympy.prevprime\(x\) với x là random.randint\(1,4e10\) đó chính là modulo như trong RSA là n , c là đề cho . Giải ra đc 1 số nhưng mà không phải flag ,check điều kiện assert\(math.log10\(ct\) &lt;= 128\), thì có thể flag lớn hơn nên brure force [CRT](https://www.geeksforgeeks.org/chinese-remainder-theorem-set-1-introduction/) ra đc x mod tích\(n\) , brute force cho i chay: x+i\*n.

[Solve](https://github.com/rongtruong26012002/SolveFile/blob/main/solve_crypto/LIT_Leftovers_solve.py) của anh lttn ٩\(๑&gt; ₃ &lt;\)۶♥

\(chạy bằng python hay sage đều được\)

> flag{ch1nese\_f00d\_l3ft0v3r\_th30r3m\_1s\_v3ry\_d3l1c10u5}

Thanks for reading. Have a good day &lt;3

