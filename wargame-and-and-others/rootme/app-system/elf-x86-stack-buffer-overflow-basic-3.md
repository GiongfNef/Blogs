---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🐻 ELF x86 - Stack buffer overflow basic 3

```c
#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
 
void shell(void);
 
int main()
{
 
  char buffer[64];
  int check;
  int i = 0;
  int count = 0;
 
  printf("Enter your name: ");
  fflush(stdout);
  while(1)
    {
      if(count >= 64)
        printf("Oh no...Sorry !\n");
      if(check == 0xbffffabc)
        shell();
      else
        {
            read(fileno(stdin),&i,1);
            switch(i)
            {
                case '\n':
                  printf("\a");
                  break;
                case 0x08:
                  count--;
                  printf("\b");
                  break;
                case 0x04:
                  printf("\t");
                  count++;
                  break;
                case 0x90:
                  printf("\a");
                  count++;
                  break;
                default:
                  buffer[count] = i;
                  count++;
                  break;
            }
        }
    }
}
 
void shell(void)
{
  setreuid(geteuid(), geteuid());
  system("/bin/bash");
}
```

Phân tích:

* Dựa vào thứ tự khai báo biến, ta có thể phát thảo thứ tự trong stack như sau:

<figure><img src="../../../.gitbook/assets/image (35).png" alt=""><figcaption></figcaption></figure>

* Như vậy khác với các chall 1 và 2, lúc này biến `check` được khai báo sau biến `buffer` ta không thể nhập tràn để ghi đè giá trị  lên check&#x20;
* Lúc này review lại code để ý một hàm lạ lẫm  `read(`[`fileno`](https://man7.org/linux/man-pages/man2/read.2.html)`(stdin),&i,1);`

<figure><img src="../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

* Như vậy hàm này giúp ta đọc từng kí tự của chuỗi nhập vào, nên nhớ buff được lưu dưới dạng chuỗi mình có thể truy xuất từng phần tử :

<figure><img src="../../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

* Để ý case sau:

```c
case 0x08:
    count--;
    printf("\b");
```

* Như vậy ý tưởng lúc này ta có thể đọc lại từng phần tử của check và thay đổi giá trị của chúng bằng việc giảm giá trị biến count và ghi đè vài từng bytes tương ứng với format little-endiant

```c
default:
  buffer[count] = i;
  count++;
```

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

> flag: Sm4shM3ify0uC4n
