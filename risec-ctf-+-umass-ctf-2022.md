---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# RISEC CTF + UMass CTF 2022

<mark style="color:blue;">`Web Challenge`</mark>

## RISEC CTF&#x20;

### Pretty Horrible Program 1

```
  <?php
  if (isset($_GET['bingus'])) {
    $input = $_GET['bingus'];
    $to_replace = 'bingus';
    $clean_string = preg_replace("/$to_replace/", '', $input);
    echo "<p>Your string is: $clean_string</p>";
    if ($clean_string == $to_replace) {
      echo "<h2 class=\"answer\">Bingus <span style=\"color: green;\">IS</span> your beloved</h2>";
      output_flag();
    } else {
      echo "<h2 class=\"answer\">Bingus <span style=\"color: red;\">IS NOT</span> your beloved</h2>";
    }
  }
  ?>
```

* Notice that $clean\_string genererated by replacing&#x20;
* So that we just input something that after replacing. it's equal to 'bingus'

demo:

![](<.gitbook/assets/image (3).png>)

![](<.gitbook/assets/image (8).png>)



### Pretty Horrible Program 2

```
class User
  {
    public $role = 'Admin'; 	
}

$default_user = new User;
$_COOKIE = serialize($default_user);
setcookie(
    'user',
    serialize($default_user)
  );
$a=unserialize($_COOKIE);
echo "$_COOKIE"
```

### Pretty Horrible Program 3

```
<?php
  if (isset($_GET['input1']) and isset($_GET['input2'])) {
    if ($_GET['input1'] == $_GET['input2']) {
      print '<h3 class="error">Nice try, but it won\'t be that easy ;)</h3>';
    } else if (hash("sha256", $_GET['input1']) === hash("sha256", $_GET['input2'])) {
      output_flag();
    } else {
      print '<h3 class="error">Your inputs don\'t match</h3>';
    }
  }
  ?>
  <p>See if you can make the sha256 hashes match</p>
  <br />
  <a href="/php3/index.php?source=true">Source Code</a>
  <form method="get">
    <input type="text" required name="input1" placeholder="Input 1" />
    <p>Hash: <?php if (isset($_GET['input1'])) print hash("sha256", $_GET['input1']) ?></p>
    <input type="text" required name="input2" placeholder="Input 2" />
    <p>Hash: <?php if (isset($_GET['input2'])) print hash("sha256", $_GET['input2']) ?></p>
    <input type="submit" />
  </form>
</body>

</html>
<?php
```

Workflow:

* At first, i just try to find around the key work "SHA256 collision" but we got [<mark style="color:blue;">this one</mark> ](https://crypto.stackexchange.com/questions/47809/why-havent-any-sha-256-collisions-been-found-yet)<mark style="color:blue;">,</mark> it takes about ≈3.6×1013 years to find, so that it's not a practical option.
* After that i focused on '==' in php. Searching around and i got [<mark style="color:blue;">this</mark> ](https://www.invicti.com/blog/web-security/php-type-juggling-vulnerabilities/)and [<mark style="color:blue;">this</mark>](https://owasp.org/www-pdf-archive/PHPMagicTricks-TypeJuggling.pdf)<mark style="color:blue;"></mark>
* <mark style="color:blue;"></mark>

## UMass CTF
