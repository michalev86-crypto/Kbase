
=== sort ===
will sort files or resoults of acommand / program
parameters:
-r Reverse
-k sort by column like: -k 2 will sort Michael Levinshtein names by last  name

=== uniq  ===
will remove duplicate lines wich are above each other
* file must be sorted before used

	sort ls.txt | uniq
	solrt - u ls.txt 
will give same resoult..

find duplicated lines:
cat users.txt | sort | uniq -d

==== how to filter lines?? ===  grep ===

	grep -F 'pattern' file.txt
	[command] | grep -F 'pattern'
* -F will disable regular exprasions

=== Characters Replacement ===
	tr command works on caracters lavel and not on strings: exmple:

micha@ubuntu2:~/Desktop/temp$ echo 'bash' | tr 'b' 'd'
dash
micha@ubuntu2:~/Desktop/temp$ echo 'bash' | tr 'bh' '12'
1as2
micha@ubuntu2:~/Desktop/temp$

	if we want to convert all small leters to uppercase:

micha@ubuntu2:~/Desktop/temp$ echo 'michael' |tr 'a-z' 'A-Z'

using tr to DELETE carcters!: using -d

	micha@ubuntu2:~/Desktop/temp$ echo 'hellow world' | tr -d ' '
	hellowworld
	
=== cut ==
parameters:
-b bytes
-c carecters
-d delimiter
-f fields
examples
	uptime | cut -b 1-10
	uptime | cut -b 1- will start from 1 to the end
	uptime | cut -b 3 only 3rd
some carecters are bigger than 1 byte so it might be different c and b

	micha@ubuntu2:~$ uptime | cut -d ' ' -f 2
	17:47:08
=== edditing strings with sed ===
can delete, insert or replase lines
parameters:
s -replase
g- multiple times and not only first expressin

	micha@ubuntu2:~$ echo 'hello world world' | sed 's/world/bash/g'
	hello bash bash

=== using solution on log file: ===

log file looks like: 
139.29.237.176 - - 12/Jul/2049:03:26:47 +0000 "GET /addon/adblocker.zip HTTP/1.1" 200 5899 "https://www.you-robot.com/robot-friends.html" "Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101 Firefox/93.0"
215.128.69.100 - - 12/Jul/2049:03:26:47 +0000 "GET /archive/reports.zip HTTP/1.1" 200 2379 "https://www.aquatic-adventurers.com/ocean-observatory.html" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"

to find how many times zip files ware downloded:
	micha@ubuntu2:~/Desktop/temp$ less access.log | grep -F '.zip' | wc -l
	4061
to find how many different zip files were downloaded:
	micha@ubuntu2:~/Desktop/temp$ grep -F '.zip' access.log | cut -d ' ' -f 7 | sort | uniq | wc -l
	27

