---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# 🍃 OverTheWire: (old) - Bandit

``[`Bandit`](https://overthewire.org/wargames/bandit/bandit0.html)``

## Bandit Level 0

![](<../../.gitbook/assets/image (20).png>)

> ssh username@hostname
>
> so that the command is: \`ssh bandit0@bandit.labs.overthewire.org -p 2220\`

![](<../../.gitbook/assets/image (28).png>)

![](<../../.gitbook/assets/image (37).png>)

> boJ9jbbUNNfktd78OOpsqOltutMc3MY1

## Bandit Level 0 → Level 1

![](<../../.gitbook/assets/image (42) (2).png>)

![](<../../.gitbook/assets/image (36).png>)

[command](https://unix.stackexchange.com/questions/189251/how-to-read-dash-files)

![](<../../.gitbook/assets/image (34).png>)

```
bandit1@bandit:~$ cat ./-
CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
bandit1@bandit:~$ cat <-
CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
bandit1@bandit:~$
```

## Bandit Level 1 → Level 2

![](<../../.gitbook/assets/image (14) (1).png>)

```
bandit2@bandit:~$ ls
spaces in this filename
bandit2@bandit:~$ cat spaces\ in\ this\ filename
UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
bandit2@bandit:~$
```

## Bandit Level 2 → Level 3

![](<../../.gitbook/assets/image (39) (1) (1).png>)

![](<../../.gitbook/assets/image (9) (2).png>)

```
bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ cd inhere/
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$ ls -a
.  ..  .hidden
bandit3@bandit:~/inhere$ cat .hidden
pIwrPrtPN36QITSp3EQaw936yaFoFgAB
bandit3@bandit:~/inhere$
```

## Bandit Level 3 → Level 4

![](<../../.gitbook/assets/image (10) (1).png>)

![](<../../.gitbook/assets/image (25).png>)

```
bandit4@bandit:~$ ls
inhere
bandit4@bandit:~$ cd inhere/
bandit4@bandit:~/inhere$ ls
-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09
bandit4@bandit:~/inhere$ cat *
cat: invalid option -- 'f'
Try 'cat --help' for more information.
bandit4@bandit:~/inhere$ cat ./*
�/`2ғ�%��rL~5�g��� �������p,k�;��r*��        �.!��C��J     �dx,�e�)�#��5��
                                                                                   ��p��V�_���ׯ�mm������h!TQO�`�4"aל�?��r�l$�?h�9('���!y�e�#�x�O��=�ly���~��A�f����-E�{���m�����ܗMkoReBOKuIDDepwhWk7jZC0RTdopnAYKh
�T�?�i��j��îP�F�l�n��J����{��@�e�0$�in=��_b�5FA�P7sz��gNb
```

koReBOKuIDDepwhWk7jZC0RTdopnAYKh

## Bandit Level 4 → Level 5

![](<../../.gitbook/assets/image (41).png>)

``[`human-readable file`](https://unix.stackexchange.com/questions/313442/find-human-readable-files)``

![](<../../.gitbook/assets/image (38).png>)

`DXjZPULLxYr17uwoI01bNLQbtFemEgo7`

## Bandit Level 5 → Level 6

![](<../../.gitbook/assets/image (7) (2).png>)

> `find / -user bandit7 -group bandit6 -size 33c`

![](<../../.gitbook/assets/image (40).png>)

> `find / -user bandit7 -group bandit6 -size 33c 2>&1 | grep -F -v Permission`

[`2>&1 meaning`](https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean)``

![](<../../.gitbook/assets/image (30) (1).png>)

```
bandit6@bandit:/home$ find / -user bandit7 -group bandit6 -size 33c 2>&1 | grep -F -v Permission | grep -F -v directory
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:/home$ cat /var/lib/dpkg/info/bandit7.password
HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
bandit6@bandit:/home$
```

## Bandit Level 7 → Level 8

![](<../../.gitbook/assets/image (6) (2) (1).png>)

```
bandit7@bandit:~$ cat data.txt | grep millionth
millionth       cvX2JJa4CFALtqS87jk27qwqGhBM9plV
bandit7@bandit:~$
```

## Bandit Level 8 → Level 9

![](<../../.gitbook/assets/image (8) (2) (1).png>)

```
bandit8@bandit:~$ cat data.txt |sort |uniq -u
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

## Bandit Level 9 → Level 10

![](<../../.gitbook/assets/image (27) (2).png>)

```
bandit9@bandit:~$ strings data.txt  | grep =
========== the*2i"4
=:G e
========== password
<I=zsGi
Z)========== is
A=|t&E
Zdb=
c^ LAh=3G
*SF=s
&========== truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
S=A.H&^
bandit9@bandit:~$
```

## Bandit Level 10 → Level 11

![](<../../.gitbook/assets/image (24) (2).png>)

```
bandit10@bandit:~$ cat data.txt | base64 -d
The password is IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
bandit10@bandit:~$
```

## Bandit Level 11 → Level 12

![](<../../.gitbook/assets/image (26).png>)

![](<../../.gitbook/assets/image (21) (2).png>)

![](<../../.gitbook/assets/image (22).png>)

```
bandit11@bandit:~$ cat data.txt | tr 'a-zA-Z' 'n-za-mN-ZA-N'
The password is 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
bandit11@bandit:~$
```

## Bandit Level 12 → Level 13

![](<../../.gitbook/assets/image (5) (1).png>)

In this challenge, you just have to know decompress a file with gzip, bzip2 and xxd . Knowing how to know file extention by `file command`

![](<../../.gitbook/assets/image (29) (2).png>)

> 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

