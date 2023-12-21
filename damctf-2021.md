# DamCTF 2021

_**Note : A JOURNEY TO GAIN KNOWLEDGE**_

## _**#**_crypto/xorpals



[Challenge](https://github.com/GiongfNef/ChallFile/blob/main/DamCTF2021/crypto\_xorpals.txt)

So we can easily see that, this chall is as same as set1 chall4 in [cryptopals](https://cryptopals.com/sets/1/challenges/4)

this is my solve and another way i consulted

My code:

```
import string

def generateKey(string, key):
    key = list(key)
    if len(string) == len(key):
        return(key)
    else:
        for i in range(len(string) -
                       len(key)):
            key.append(key[i % len(key)])
    return("" . join(key))
def xor_bytes(key_stream, message):
    length = min(len(key_stream), len(message))
    return bytes([key_stream[i] ^ message[i] for i in range(length)])

alpha = string.printable
with open('flags.txt') as f:
    m = f.read() 
for line in m.split('\n'):        
    m = bytes.fromhex(line)
    for _ in alpha:
        key = generateKey(m,_)
        print('========================')
        print(xor_bytes(key.encode(),m))
```

After running this fucking shit, you just find the key word: 'dam{'&#x20;

flag : b'dam{antman\_EXPANDS\_inside\_tHaNoS\_never\_sinGLE\_cHaR\_xOr\_yeet}'

Another code i had consulted from [IOKernel](https://cryptik.io/author/chi/), this one is better

```
#!/usr/bin/env python3
from string import ascii_letters
from Crypto.Util.strxor import strxor_c

# Adding numerals to the dataset
dataset = ascii_letters+ "123456890"

# --------------------------------------------------------
# ---------------------- functions -----------------------
# --------------------------------------------------------
def get_score(message):
    '''
    a function that takes input string and using letter 
    frequency it scores it. The closd the score is 
    to 1.00, the more realistic.
    '''
    score = 0
    freq = {'a': 0.0812, 'b': 0.0149, 'c': 0.0271, 'd': 0.0432,
    'e': 0.1202, 'f': 0.0230, 'g': 0.0202, 'h': 0.0592, 'i': 0.0731,
    'j': 0.001, 'k': 0.0069, 'l': 0.0398, 'm': 0.0261, 'n': 0.0695,
    'o': 0.0768, 'p': 0.0182, 'q': 0.0011, 'r': 0.0602, 's': 0.0628,
    't': 0.091, 'u': 0.0288, 'v': 0.0111, 'w': 0.0209, 'x': 0.0017,
    'y': 0.0211, 'z': 0.0007, ' ': .1}
    for c in message:
        score += freq.get(c, 0) #if it is not an alphabet, give it a score of 0
    return score

# --------------------------------------------------------
# ------------------- Problem Solution -------------------
# --------------------------------------------------------
highestscore = 0
# open the provided file
with open('flags.txt') as f:
    for line in f:
        # strip the lines from the newline character \n
        line = bytes.fromhex(line.strip())
        for c in dataset:
            #convert the character to an integer to use it in the strxor_c function
            result = strxor_c(line, ord(c))
            #decode 'UTF-8' from bytes to string of text
            #if it throws an error give it a value of 0 (likely junk data)
            try:
                result = result.decode()
            except UnicodeDecodeError:
                result = ' '
            score = get_score(result)
            # to store the highest  scored combination. To be shown at the end of script
            if (score > highestscore):
                highestscore = score
                output = 'Character:'+c+"\nXOR'd output: "+result+'score ='+str(score)
                original_line = line
print('Original line:', original_line)
print(output)

-- consulted from: https://cryptik.io/100/cryptopals-write-up-set-1-challenge-4/
```

Thanks for reading. Have a nice day <3 .



_****_
