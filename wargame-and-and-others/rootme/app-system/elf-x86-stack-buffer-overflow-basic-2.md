---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🦊 ELF x86 - Stack buffer overflow basic 2

```c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
 
void shell() {
    setreuid(geteuid(), geteuid());
    system("/bin/bash");
}
 
void sup() {
    printf("Hey dude ! Waaaaazzaaaaaaaa ?!\n");
}
 
void main()
{
    int var;
    void (*func)()=sup;
    char buf[128];
    fgets(buf,133,stdin);
    func();
}
```

* Về cơ bản ý tưởng vẫn là ghi tràn biến buff để ghi đè giá trị lên biến trước đó&#x20;
* Lúc này chính là địa chỉ của func : `void (*func)()=sup;` , tức là thay vì trỏ tới địa chỉ của sup như thường lệ:

<figure><img src="../../../.gitbook/assets/image (6) (2).png" alt=""><figcaption></figcaption></figure>

* Sau khi attack func lúc này sẽ trỏ tới địa chỉ shell và thực thi gọi nó
* Để biết được địa chỉ của hàm shell, ta có thể dùng gdb hoặc pwndbg:

<figure><img src="../../../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (14).png" alt=""><figcaption></figcaption></figure>

* Cuối cùng ta chuyển địa chỉ sang little-endian, get shell và cat flag:

<figure><img src="../../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

> flag: B33r1sSoG0oD4y0urBr4iN
