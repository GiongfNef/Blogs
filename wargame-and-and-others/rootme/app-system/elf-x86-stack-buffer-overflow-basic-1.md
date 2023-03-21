---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🐰 ELF x86 - Stack buffer overflow basic 1

Code chall:

```c
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>
#include <stdio.h>
 
int main()
{
 
  int var;
  int check = 0x04030201;
  char buf[40];
 
  fgets(buf,45,stdin);
 
  printf("\n[buf]: %s\n", buf);
  printf("[check] %p\n", check);
 
  if ((check != 0x04030201) && (check != 0xdeadbeef))
    printf ("\nYou are on the right way!\n");
 
  if (check == 0xdeadbeef)
   {
     printf("Yeah dude! You win!\nOpening your shell...\n");
     setreuid(geteuid(), geteuid());
     system("/bin/bash");
     printf("Shell closed! Bye.\n");
   }
   return 0;
}
```

Phân tích:

* Lần lượt khai báo ba biến `var`, `check` và `buf` như vậy khi lưu trong bộ nhớ stack thứ tự: `var` sẽ cao nhất sau đó đến `check` và cuối cùng là `buf`
* Mục tiêu của ta là bypass được vế if thứ 2 để giá trị cửa biến `check` == 0xdeadbeef
* Giá trị ta có thể control được là buf, khi khai báo buff có giới hạn 40 kí tự tương đương với 40 bytes
* Hàm fget cho phép ta nhập 45 kí tự vào buff tương đương 40 bytes cho buf và 5 bytes tràn, tuy nhiên ta chỉ nhập được 4 bytes kí tự còn lại chính là null

<figure><img src="../../../.gitbook/assets/image (3) (1) (2).png" alt=""><figcaption><p>Địa chỉ buff lúc này chính là 4 kí tự A</p></figcaption></figure>

Ý tưởng và khai thác:

* Như vậy ý tưởng lúc này chính là viết 40 bytes để chứa đủ biến buff sau đó truyền vào địa chỉ 0xdeadbeef
*

    <figure><img src="../../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>
* Đến đây có vẻ đúng hướng rồi, cuối cùng chuyển địa chỉ cần nhập sang little-endian là ok
* Có thể dùng [<mark style="color:blue;">`pwntool`</mark> ](https://github.com/Gallopsled/pwntools)để đổi nhanh

<figure><img src="../../../.gitbook/assets/image (21).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (5) (6).png" alt=""><figcaption></figcaption></figure>

* Ý tưởng có vẻ đúng rồi, vấn đề lúc này shell đóng lại quá nhanh, do vậy ta thêm câu lệnh cat để duy trì shell và cuối cùng là cat flag

<figure><img src="../../../.gitbook/assets/image (4) (2).png" alt=""><figcaption></figcaption></figure>

flag: 1w4ntm0r3pr0np1s
