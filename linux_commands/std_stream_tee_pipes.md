
=== Streams === 
0 - input
1 - stdout
2 - stderr

	echo 'hellow' > file.txt
	ls > ls.txt
 	if > is used and the file exists => the file will be overweitten!!

	ls >> ls.txt will add data to the end and not overwrite
if somthing goes wrong like file dosn't' exists, error will be shown on terminal and nothing will be written
becouse we redirect only "stdout" but not "stderr"

to stream errors: 2>
	example:
	du file_not_exxist.txt 2> error.txt
	du file.txt file_not_exsist.txt >> du.txt 2>>error.txt

if we need to ignore error massages in bash, can use:
	command ______ 2> /dev/null
same for show only errors:
	command _____ 1> /dev/null

== redirect stderr to stdout:

	2>&1
for example:
	du file_not_exists.txt file.txt> redirect.txt 2>&1
*in this case the order of the output will usally will be first the stderr and after that the stdout becuse the stdout is bufferd and waits


=== Pipes ====

allows to combine some commands togtther to use the output of one command as an input of other
for example to count num of files in a folder:

	ls | wc -l	=> use the ls output as an input of wc
importent!! if we try ls > wc -l the bash will create wc file and will use ls -l ---> NOT WORKING!
 

	du romeo.txt file_not_exist.txt 2>&1 > /dev/null | wc -l  expain:
		take stderr and send it to stdout, the stdout to null, and the resoult to wc
==== tee ===ou

the "tee" command will redirect the resuolt of a program to the std AND to a file so the risult will be BOUGHT
for example:
	micha@ubuntu2:~/Desktop/temp$ echo "hello" | tee hello.txt
	hello
	
	micha@ubuntu2:~/Desktop/temp$ cat hello.txt 
	hello

	ping google.com 2>&1 | tee ping.txt
** if 2>&1 is not used, and or connection fails, errors will go to stderr and not to the pipe
** tee will OVERWRITE the txt file.

