#!/bin/bash
echo -e - alow spacial carecters like \n

file managment:
	rm -remove
	rm -rf -remove recursiv including sub folders
	mv - move file
	cp - copy
	touch - update time stamp or create if not exists
Reading files:
cat (file name)

less (file name)
	p50 - jump to 50% of the text
	= show corrent loaction
	-N show row numbers
	/(text) - forward search for (text)
	?(text) back search for (text)
	&pattern          *  Display only matching lines.
	n - find next

wc - word count

wc file.txt
	wc -l (file.txt) number of lines
	wc -w (file.txt) number of words
	wc -c (file.txt) number of bytes
	(wc file.txt = wc -lwc file.txt by defoult!)

du -disk usage  will show all files and folders with file size
	-s summery (or just the sum of all)
	-h will show more readble for humens with k ,mb. gb etc..


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
==== tee ===

the "tee" command will redirect the resuolt of a program to the std AND to a file so the risult will be BOUGHT
for example:
	micha@ubuntu2:~/Desktop/temp$ echo "hello" | tee hello.txt
	hello
	
	micha@ubuntu2:~/Desktop/temp$ cat hello.txt 
	hello

	ping google.com 2>&1 | tee ping.txt
** if 2>&1 is not used, and or connection fails, errors will go to stderr and not to the pipe
** tee will OVERWRITE the txt file.

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


==== envirment variebles ====

env - show storred shell variebles

echo "${PWD}" = PWD
	

create environment variables:
	export VAR=value

rewerite variables:
	VAR=new_value

delete variables: 
	unset VAR

PATH -> all folders with excuteble programs!

	echo "${PATH}"
		/home/micha/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin

=== add directory to PATH: ===
	micha@ubuntu2:~/Desktop$ cd ~
	micha@ubuntu2:~$ mkdir bin
	micha@ubuntu2:~$ cd bin
	micha@ubuntu2:~/bin$ pwd
	/home/micha/bin
	micha@ubuntu2:~/bin$ PATH="${PATH}:/home/micha/bin"
	micha@ubuntu2:~/bin$ echo $PATH

make programe exacutable:

	touch costom_programe
	chmod +x custom_programe
	
	for example:
		#!/usr/bin/python3
		print ("Hello Micha")
		
		or: import os
			print(os.environ) => will print enviroment variebles like env command

	

find program location:  ( which )
	micha@ubuntu2:~/bin$ which cat
	/usr/bin/cat

set TEMPORERLY system variable for a program:
LOGIN_CONFIG="TEMP SETTING" python3 env.py -> the setting will be changed once

== alias - shell shortcuts valid only in the corrent session  ===

	alias gohome='cd ~'
to list all existing alias: just command alias.
unalias - will delte alias

=== configurating shell -- set command ===
to enable a feature:
	set -[fiture]
to disable a feature:
	set +[fiture]

usefull parameters:

	set -x	- xtrace: enables that each command that the shell executes will be printed
	allows to debug easely
	set -t  - terminate the shell after  executing one command
		set -t ; echo 'example' > file.txt
=== configureating bash -- shopt command

shopt is different from set becouse set works on the sh and shopt on bash and not part of the sh shell

usefull parameters:
	shopt -u disabble fiture
	shopt -s autocd
			micha@ubuntu2:~$ shopt -s autocd
			micha@ubuntu2:~$ Desktop/
			cd -- Desktop/
			micha@ubuntu2:~/Desktop$
	shopt -s cdspell - cd will work even if there was a small spelling mistake:
	
=== ps1 variebe : prompt streang 1===
defines the apppearence of the primery shell prompt
	micha@ubuntu2:~/Desktop$ PS1='\u\H$ '
		micha~/Desktop$
usefull psrameters:
\u -username
\h -hostname up to the first "."  (ubounto2)
\H -complete hostname
		PS1='\u@\H'  => micha@ubuntu2
\w -full path
\W -last directory of the full path
\t - time in 24 hour format
\@ - time in 12 hour format (am/pm)

	useful format: PS1='\u@\h:\w$ ' =>	micha@ubuntu2:~/Desktop/temp$ 

TO EDIT BASH PERMINANTLY =>  nano ~/.bashrc

=== TERM varieble  === colors

toe -a -> show all terminals the shell can comunicate (even vt100 from 1978)
	echo -e "\e[36;41":

bold text: (lecture 108)
	infocmp will show all avliable supported in the bash
		infocmp |grep bold
		bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, civis=\E[?25l,
	 	micha@ubuntu2:~/Desktop/temp$ echo -e "\E[1mMY TEXT"
			MY TEXT
			
	sgr0=\E(B\E[m => escape to reset all settings : echo -e \E(B\E[m 
	setab and setaf  are same but to reset colors (find it in infocamp)
	
	=== command substitution  ===
	
	we can collect an output of a program and then use it
like: 	echo " this is the output: $(ls)"

=== tput and escape sequenses

	tput clear : same as clear command, sends ^[[H^[[2J^[[3J sequnce to clear the screen
	tput cap 5 20 will move cursor to 5 (vertical) and 20 (horizontal) possition
	tput bold
	tput sgr0 will reset all to normal
	tput smul / rmul - start and stop underline text
	tput steaf [color] - set forground color
	tput serab [color] - set background color
	
			 echo "$(tput bold)bold tex...$(tput sgr0)normal text"
				bold tex...normal text
	to print all colors from 1 to 15 with for loop:
 i in {0..15}; do echo "$(tput setab ${i}) color: ${i}$(tput sgr0)"; done
	for
to qurey the terminal  :
	tput colors
	tput cols
	tput lines
will return the info from terminal and not from infocmp



	
==== PS1 & escape sequences (like tput sgr0) combination:
The problem:
bash needs to know how long our ps1 prompt is and this is calculated automaticly
BUT: escape sequences are also count as charecters and it will miscalculate the possion and will show it wrong
the solution:
to wrap all escape sequences into the following code:
	\[...\]

to disable charcters, we can use backslash \ 1119escaping):
	ps1="\$Hello" => will set the environment variable ps1 to "$Hello" and prevent the dollar
	from referring to a vriable

TIPS:
unicod can be used (if supported)
at the end of the PS1 it is recommended to add sgr0 so all the text after the ps1 will be normal:
	ps1="......$(tput sgro0)"


nice option for PS1:
PS1="\[$(tput setaf 2)\]→ \[$(tput setaf 6)$(tput bold)\] \W \[$(tput setaf 3)(\t)$(tput sgr0)\]\$ "

=== to make it PERMINNET ===

1. 	nano ~/.bashrc
2. add PS1=...... at the end

====  SHELL Expannsions ====

 before executing the command, the shel "rewrites" and parses the command

 1. file name ecpansion:
 	ls *  => in this case the * is being expanded
 	the bash gets the content of the directory and will proses those items to the ls command so the ls will run on all the directoris and files
 	echo * will list all files and folders like ls an can be used like: echo ?.txt or echo im*.txt
 2. ~  	home folder ${HOME} can be changed to any other folder but not recommended to change
 	if we use ~+ will expand to $PWD like echo ~+ is same like PWD
 
 3.VARIABLE expansion ($HOME or $PATH are only examples)
 will always start with a $ like echo $HOME the bash will rewrite the command and will put our variable into the command, best to be used with ${VARIABLE}
 the $ only uset to access the varieble for the bash
 
 4. # extantion will count the number of bytes in the string
 	for example: micha@ubuntu2:~$ echo $PATH
/home/micha/.local/bin:/home/micha/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
		micha@ubuntu2:~$ echo ${#PATH}
		47
5. to cut the string we can use ${HOME:start:lengh}
6. to replase substring (one time): ${HOME/pattern/replacement}
7. to replase substring (all occurences, use dubble //): ${HOME//pattern/replacement}

=== word splitting ===

bash preforms word splitting on our input
this heppens after our command has been potetially rewritten by expansions
for example:
touch a.txt b.txt
the command will be splitted into 3 different words:
touch
a.txt
b.txt
the first (touch) will be the program and the 2nd and 3rd will be the paramiters of the touch
it will every time the bash will find delimiter like spase, tab or new line ($IFS)

	qouts like '' or "" will disable word splitting
for example: touch a file.txt will create two files (a, file.txt)
			 but touch 'a file.txt' will create afile named: a file.txt 

1. cat $PWD/*.txt  - no quotes - all avalieble shell extantions will be applied
2. cat 'PWD/*.txt' - single qoutes - all extentions disabled, word splitting disabled
3. cat "PWD/*.txt"	- dubble qoutes - 	most expansions like ~, * word splitting BUT certion expansions will stil work like variebles and paramiters

COUSION: it is NOT recommended to use file names are meaning commands or parameters
it is recommended to put variebels in "{}"

try to refer to filenames in the same directory as ./file.txt

=== ESCAPING ==

the backslash \ disabels the normal behavior of the next chracter like"
	micha@ubuntu2:~$ echo "\""  so the result will be just "

=== BRASE EXPANSION ==
as of bash 4 it is possible to automaticly expand strings of charecters (brase expansion):
echo data.{csv,txt} -> will expend to echo data.csv data.txt
echo {a..z} will write the abc...
touch {a..z}.txt will create files from a.txt to z.txt

=== command substitution ==
we can execute a command and use the output as a replasement for example:
echo "my corrent working directoru is: $(PWD)"
echo 'the size of my home directory is:'"$(du -sh ~)"

=== dinemic input & output  === (lecture 124)
tree command will show tree of folders and files
diff command will show the deference betwen two text files
if we want to compare contents of two folders we can redirect the contents to files like:
ls folder1/ >folder1_contents and then compare withe diff folder1_contents folder2_..

or we can use PROCESS SUBSTITUTION: (it creates a temporary file with the results)
<(command)
so we can just use:
	diff <(ls./folder1) <(ls./folder2)
we can use wc -l < <(ls) and is same like ls | wc -l

to use a temporary file as an input to a command:
>(command)

more expansions at: https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html


**** PART 3 - LINUX ****
files on linux:
each file will reference to inode of the file that will store metadata:
file type
access rights
number of hardlinks
file size
last modifed date
last access date
whre is data phsically stored

folders will reference to an inode that will store the next metadata:
access rights
permissions
whre is the data phisicly stored (files names)

in linux and unix everything is a file
ordinary file (-)
Directories (d)
symbolic links (l)
character device (c)
block device (b)
Named pipes(p)
sockets(s)


symlink (symbolic links (l)) are spesial kind of files on unix,
it serves as reference to another file ot directory to shortcut to another destanation
	ln command will create the simlink file
		ln -s Desktop/ abc
		cd abc/

symlink on WINDOWS:
open powershell (run as administrator)
New-Item -ItemType SymbolicLink -Path file.txt -Target C:\Users\.... document.txt

Hard links:

with hard links we can use multiple file names that points to the same inode of a file so if one file name will be delited, the information will stay
to create hard link we will use same command ln but witout flags (-s)
we can't ' create hard links to directories (to prevent loops)
--What is it good for? --
with hardlinks we can create and orgenize files in different ways and work with same file on both directories

copy files with hard link
cp -al source destanation
this will copy the whole sorce folder and create hardlinks for all files
we will not nedd any additional storage

increasing the inode limit:
->during the creation of the file system, space is reserved for inodes
-> this space cant be used for amything else
-> we can show how many inodes are beong used:
	df -ih  --> i for inodes and h for humen read

if our application usses lots of small files and reaches the limit of the inodes -
the proccess or application crash or can't ' be started
operating system crashes
to solve this we can remove files or compress multiple files into an archive (like *.tar) looks like a folder and not commpressing
we can store files in other drive and mount it as a folder
we can recreate filesystem with higer inode limit (first create a backup!)

Bufferd VS unbufferd input / output

Unbufferd:
-> Directly handels data between the I/O device and the program
-> Real-time data -immediate access to the data
-> control: offers more percise controle over data flow and timing
*examples:
-> reading data from keyboard or sensors

Bufferd:
->utilizes a temporary storage area (buffer) to hold data before it's ' being recived / sent to the i/o device
-advantages:
-> effiency: reduces the number of i/o opperations by accumulating data before processing
->preformance: echances speed espesialy for disk and network operations
-> data integrity: simplifies the implementation of data integrity checks
->ideal for large and sequemential data transfers

====DEVICES ===
psudo devices1:
-> /dev/null -(when reading returns eof -end of file, when writing discards the information)
-> /dev/reandom - (produces stream of random numbers from system enviromental noise)
	cat /dev/random >~/random.txt
-> /dev/urandom - (same as random but may reuse already used noise)
-> /dev/stdin, -> /dev/stdout,-> /dev/stderr, 

=== SYSTEM INSIGHTS ==
	cat /proc/cpuinfo -> shows cpu information and number of cores avaliable
	cat /proc/meminfo -> shows memory avaliabele information
	cat /proc/version  -> shows the linux, kernel and etc running
	cat /proc/uptime  -> shows up time, idle time
 	cat /proc/loadavg
 	
 == file system hierarchy standard   (FHS)==
 
 /: -> root directory
 /bin: -> contains essentioal command binaries required for users, in new versins merged and simlinked into /user/bin 
 /boot: ->contains bootloader files 
 /dev: -> contains device files that represents hardware and software devices
 /etc: -> system-wide configuration files and directories (text files that can be eddited to change system configuration)
 /home: -> users home folders
 /lib: -> contains library files that supports the binaries located under /bin and /sbin
 /media: -> contains mount points for removable storge media
 /mnt: - > mount points for additional file systems
 /opt -> optional application software packages can be stored here
 /proc: -> virtual filesystem, provides information about processes and the kernel
 /root: contanins the personal data for the root user (home folder)
 /run: -> run-time data, those fils will be removed during boot (temporary)
 /run/systemd: -> temporary data
 df -h will show mounts and usage of the file system
 /sbin: -> same as bin folder but for system binary files used by root user. useally merged into /user/sbin
 /srv: -> files for services if not stored in var, used often for data by ftp servers
 /sys: information about devices, drivers and kernel features
 /tmp: contains temporary files created by the system and users, deleted on reboot. used to create different subfolders to different applications
 /usr: contains shareble, read-only data
 /usr/local: -> files that shuold not be shared between multiple computers
 /var: -> contains variable data files such as logs, databases, websites and emails == this one shuld be backed up! ==
 /snap -> used to install applications
 /lost + found: ->used for recovery
 
 
 === USER MANAGEMENT ===
 
user types:
Root user -> highest privileges, user id: 0, only one user.
regular user -> limited privileges
service users -> for spesific tasks, allows to safely run a webserver, databases, etc
gruops -> all users have a primery group, and can be assigned to zero to unlimited additional groups
 
 cat /etc/passwd  -> contains basic users information, name, group, description, home directory, defoult shell
 etc/shadow -> user encripted data like passwords, date of last pass change 
 etc/group -> shows all groups for each user
 
 useradd:
 syntax: useradd [options] username
 most important options are:
 -m ->create home directory (if we are creating service user he will not need one)
 -d -> set custom home directory
 -s -> specify defoult shell
 mange groups
 -g -> specify primary group insted of using defoult configuration
 -G -> add user secondary group
 for example: $ sudo useradd -m -d /home/user1 user1

to manage and set PASSWORDS:
syntax: passwd [options] [username]
important options:
-S -> Display password status
-d -> delite password
-n -> set minimum password age (days)
-x -> set maximum password age (days)
-l -> lock user
-u -> unlock user
if we use : $ passwd -S
	micha P 2024-12-05 0 99999 7 -1 we recive [username] [regular password] [date created] [min days] [max daays] [worning before change] [if expires can steel log in]
if we are changing our own password we can jut use passwd command, if we want to chage others or skeep policeis like 8 characters, sudo must be used.
	sudo passwd [user]

== to change and modify users: usermod ==
syntax: usermod [options] username
-c -> Change user description (full name)
-s -> change defoult shell
-d -> change home directory (-m makes the same)
-l -> change user name
-g -> change primary group
-G -> change secondary group
-aG -> add secondary group
* if user wants to change his own shell without sudo, he must use chsh -s /bin/bash

 == delite users:userdel ==
 
 syntax: userdel [options] user
 usefull options:
 -r -> removes home directory and mails
 -f -> same as -r but will force the delete even user is steal loged-in, might olso delete user group with the same name ( depending on system configuration)

grups:

How do groups work?
► Each user has a primary, and zero to many secondary groups

Primary group:
► Stored in /etc/passwd
► Default ownership for new files
► We can test this:
► touch
► ls
file.txt -al file.txt
► Secondary group(s):
► Multiple memberships allowed
► Stored in /etc/group
► This allows us to give this user fine grained access rights to our
system
► We can list a user's' groups with the following command:
► groups [username] 

sudo / wheel - will give the permission to use sudo
adm - will alow user to access log files
lp admin / lp - user can manage printers
www-data: user can use access to web server processes
plugdev: allow user to manage pluggable devices (usb etc..)

How do we add a user to a group?
► We can use the usermod command for this!
► Syntax: usermod
[options] username
► Manage groups:
► -g: Change primary group
► -G: Change secondary groups
► -aG: Add secondary group
► Depending on the system, we might also be able to use
additional tools:
► adduser[user] [group]
► deluser[user] [group]

► Syntax: usermod
[options] username
► Manage groups:
► -g: Change primary group
► -G: Change secondary groups
► -aG: Add secondary group
► Depending on the system, we might also be able to use
additional tools:
► adduser[user] [group]
► deluser[user] [group]

=== file and directory permmisions: === 

There're 3 important levels of permissions: '
► Owner (u)
► Group (g)
► Others (o)

type of permissions:
► Read (r / 4):
► Allows viewing file contents or listing directory contents
► Write (w / 2):
► Allows modifying file contents or creating / deleting files in a directory
► Execute (x / 1):
► Allows running a file as a program or accessing a directory's contents

	Examples: '
1. chmod u+x file.txt: ► Would give the owner (u) executable rights
2. chmod g-w file.txt:► Would remove the write permission for the group(g)
3. chmod o+r file.txt: ► Would give other users (o) read access to this file or directory

► chmod 754 file.txt
► First digit is for the owner:
► 7 = 4 + 2 + 1 => read, write, execute
► Second digit is for the group:
► 5 = 4 + 1 => read, execute
► Third digit is for all others:
► 4 => Read

If we want to change permissions / ownership for a whole
directory structure...
► ... we can use the parameter -R:
► chown micha :micha -R ./directory

umask -> defines the defoult permisions for new files and folders
Temporarily change it (shell session):
► umask [new umask]

We can add the umask command to one of the startup files our bash
(Example: ~/.bashrc)
► Permanently change it (for all programs):
► Usually, we can edit this in the following file:
► /etc/login.defs  => change umask and check the USERGROUPS_ENAB (read connents)

=== Sticky bit ===

If the sticky bit is set, only the owner (and root) of a file or the
directory owner can rename or delete a file
► The sticky bit is especially used for the /tmp folder

chmod
+t [folder]
► Or in octal notation:
► Set sticky bit: chmod
1777 [folder]   (the first number is the stiky bit)
► Unset sticky bit: chmod
0777 [folder]
► How can we inspect the sticky bit?
► We can use the ls -l command for this:
► ls
-l
► If the sticky bit is set:
► If the file / directory also has executable permissions for others:
► Last character will be a "t"
► Otherwise, the last character will be a "T"

===SUID = Set Usert ID ===
The executable will gain the rights of the owner
► This allows unprivileged users to access privileged resources

How can we inspect the SUID bit?
► ls
-l file
► Example:
► -rwsrwxrwx
► Lowercase s: SUID bit + execute bit
► Uppercase S: SUID bit, but without execute bit
► We can also set the SUID bit:
► chmod
u+s file
► Important:
► We should also limit write access to this file as much as possible!

=== sgid: set group id ==
We can give additional privileges based on the group
► This is the SGID: Set Group ID
► Example:
► ls
-l file
► -rwxrwsrwx
► It works the same as for the SUID:
► Lowercase s: SGID bit + execute bit
► Uppercase S: SGID bit, but without execute bit
► We can also set the SGID bit:
► chmod
g+s file



==== Procrsses ===

How do we list processes with ps?
► We can select (and combine) from several parameters:
► ps
-A, ps -e:
► Show all processes, from all users and all sessions
► ps
-f:
► Full-format listing: Show extended information, such as user, terminal,
and parent process (PPID)
► ps
-p 1234,1235:
► Show processes with process ID 1234 and 1235
► We are also allowed to omit (leave out) the -p, and even the comma:
► ps
► ps
1234 1235
--forest: ► Only Linux: Show the processes as an ASCII tree
► ps --forest
ps -l: ► Show entries in long format (a few more columns)

usefull to use ps -ef | grep 
usefull to use ps -ef | less

other way to use : ps aux (all users, user frienly and without out of terminal proccess)

===process priorities===

If our CPU switches from one program to another, it's called
"context switch"
► You don't need to remember this, but we can visualize those
context switches:
► cat/proc/[process ID]/status | grep ctxt
► cat/proc/12345/status | grep ctxt
► We can use the watch command:
► This allows us to automatically re-execute a command
► Here: Refresh the output every 0.5 seconds
► watch -n 0.5 grep ctxt /proc/12345/status

Setting the priority of a process
► Now that we know how our operating system switches between
processes... can we influence this?
► We can! We can use the niceness for this
► Niceness:
► Niceness ranges from -20 (highest priority) to +19 (lowest
priority)
► Default niceness for new processes is typically 0
► Processes with lower nicen

How do we set the niceness?
► Set the niceness for a program:
► nice
-n [niceness] [program]:
► Sets the niceness to [niceness] for a program (lower priority
than default)
► Example:
► nice
-n 19 gedit
► We can also change the priority of an existing process:
► renice
-n 19 [process ID]


pgrep - find process number easly:
to search in our programs
► And it only returns the process ID(s)!
► pgrep firefox
► Why is it so useful that we need a special tool?
► Reason: We can combine it withe expansions!
► renice
-n 19 $(pgrep firefox)
to find all processes are runed under firefox we will use pgrep -f firefox
======================
stopping and killing prograns:  ---- it helps to kill processes from other terminals running on the system
How do we send a SIGINT with kill?
► kill -s [SIGNAL] [process-ID]
► We first need to get the process ID of the process we would like to send the SIGINT to
► And then we can send the signal to the process:
► kill-s SIGINT 12345
► kill-SIGINT 12345
======================
***** SIGNALS ****
kill -l -> shows all signals
SIGINT (2) (CTRL+C) terminate from the shell and give me the controle again
SIGTERM (15) - sends terminate signal (terminate when possible - the program can ignore it)
kill -s SIGTERM [process ID] == kill -s 15 [process ID]
SIGKILL (9) - forcefully kills the process with no time to write last data or cleanup - this one is sent to the kernel and not to the process so the process will not even know it is killed
SIGSTOP - POUSE the process ftom kernel
SIGCONT -CONITNUE the process
cmatrix app - cool app to show matrix running 
** kill command will be different between diferen shels like zsh. and we have kill as a excuteble file on linux.

==== killall: =====
killall - works on process name and not only on process nuber like:
	killall firefox
	killall -s SIGINT firefox
**  exit codes: cat $? -> 0=all normal, all others like 1, 2 or else, last program exited with an error
=====
nohup - > even if parent process will terminate, the child process will continue:
if we run nohup firefox from terminal and close the terminal, firefox will continue to run becouse SIGCHLD will not be sent becouse the process is runned under higer parent.
if we have a zombie process (starts with z on ps) it means the parent process didn't 'terminated it, we can try to send SIGCHLD to the parent again.

=====
process states:
for example:
micha@ubuntu2:~$ ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  1 15:28 ?        00:00:03 /sbin/init splash
root           2       0  0 15:28 ?        00:00:00 [kthreadd]
		       1 I     0    7568       2  0  80   0 -     0 -      ?        00:00:00 kworker/u10:1-events_unbound
		       0 R  1000    7569    3492  0  80   0 -  3412 -      pts/0    00:00:00 ps

R = Running
S = Sleeping (ineruptible like firefox running in the backround but not doing any calculations)
D = Uninteraptible state -  system call usally I/O

=== monitoring process   - TOP command === 
top - > shows all process table
***  htop - more advanced tool with kill option
top - u [user] show only one user
top -d [seconds] - refrash rate
top -i -> start top with idle process hiden
top -c > show full command line used to start the process
q -> exit 
it is better redirect the output like ping -c 10 > ping.txt & or if we dont want to
keep the output we can redirect to null : ping -c 10> /dev/null &
to list running jobs in the background we use the command: jobs
to bring job back to foreground: fg command
totop program
f - > change behaveier and show new culoms and more information or change arrange way
k= kill command - for killing useage: k -> [process uid] -> 15
r - change niceness (renice)
z - z - CHANGE COLORS
W - (uppercase) -werite configuration for the next times of using top

 ***** htop *****
 much better and advanced app insted of top. in radhat or centos avaliable for enterproce
 F5  	

===== Job control =====

job VS proccess:
job can be combined from more then one process like ls | grep
jobs can run in the background
to run it in the background we will add & at the end of the command:
ping -c 10 google.com &
it is better redirect the output like ping -c 10 > ping.txt & or if we dont want to
keep the output we can redirect to null : ping -c 10> /dev/null &
to list running jobs in the background we use the command: jobs
to bring job back to foreground: fg command
to use fg on specic job we will use fg%[job number] like this:

micha@ubuntu2:~$ ping -c 100 yahoo.com > /dev/null &
[1] 13800
micha@ubuntu2:~$ ping -c 100 google.com > /dev/null &
[2] 13803
micha@ubuntu2:~$ jobs
[1]-  Running                 ping -c 100 yahoo.com > /dev/null &
[2]+  Running                 ping -c 100 google.com > /dev/null &
micha@ubuntu2:~$ fg %2
ping -c 100 google.com > /dev/null

using ctrl+z will susspend the process and will moove it to the background
to continue we can use fg%[job-id] in the foreground or
use bg%[job-id] in the background:


micha@ubuntu2:~$ ping -c 100 yahoo.com > /dev/null
^Z
[1]+  Stopped                 ping -c 100 yahoo.com > /dev/null
micha@ubuntu2:~$ fg %1
ping -c 100 yahoo.com > /dev/null
^Z
[1]+  Stopped                 ping -c 100 yahoo.com > /dev/null
micha@ubuntu2:~$ bg %1
[1]+ ping -c 100 yahoo.com > /dev/null &
micha@ubuntu2:~$ pgrep ping
13819
micha@ubuntu2:~$ kill $(pgrep ping)
micha@ubuntu2:~$ pgrep ping
[1]+  Terminated              ping -c 100 yahoo.com > /dev/null
micha@ubuntu2:~$ 

 kill %[job-id] to kill jobs

== stop jobs with output ==
ssty tostop with this command, the job will run untill it will create an output and will susspend:
for example:

micha@ubuntu2:~$ stty tostop
micha@ubuntu2:~$ ping -c 100 yahoo.com &
[1] 13888
micha@ubuntu2:~$ jobs
[1]+  Stopped                 ping -c 100 yahoo.com
micha@ubuntu2:~$ fg %1
ping -c 100 yahoo.com
PING yahoo.com (74.6.231.21) 56(84) bytes of data.
64 bytes from media-router-fp74.prod.media.vip.ne1.yahoo.com (74.6.231.21): icmp_seq=1 ttl=255 time=238 ms
64 bytes from media-router-fp74.prod.media.vip.ne1.yahoo.com (74.6.231.21): icmp_seq=2 ttl=255 time=204 ms
^C
to disable stty use: stty -tostop

the wait command:
- wait : waits untill all background jobs will finish untill running the next command
- wait 123 : waits until process id 123 will finsh
- wait %1 waits untill job id finsh
- wait -n waits untill any job will finish

example:
micha@ubuntu2:~$ ping -c 20 google.com > /dev/null &
[1] 13929
micha@ubuntu2:~$ ping -c 20 google.com > /dev/null &
[2] 13930
micha@ubuntu2:~$ ping -c 20 google.com > /dev/null &
[3] 13931
micha@ubuntu2:~$ ping -c 20 google.com > /dev/null &
[4] 13932
micha@ubuntu2:~$ wait
[1]   Exit 1                  ping -c 20 google.com > /dev/null
[2]   Exit 1                  ping -c 20 google.com > /dev/null
[3]-  Exit 1                  ping -c 20 google.com > /dev/null
[4]+  Exit 1                  ping -c 20 google.com > /dev/null
micha@ubuntu2:~$ 

or : 
micha@ubuntu2:~$ wait ; echo 'hello'
[1]   Exit 1                  ping -c 10 google.com > /dev/null
[2]-  Exit 1                  ping -c 10 google.com > /dev/null
[3]+  Exit 1                  ping -c 10 google.com > /dev/null
hello
micha@ubuntu2:~$ 

==== KEEP PROGRAM RUNNING EVEN IF TERMINAL IS CLOSED ===
- nohup

=======
========   packgemengment  =========
install manualy a packge
discover linux version: lsb_release -a 
after choosing right package with the right machine configuration and architecture, download tit
navigate to ~/Downloads
install:	sudo dpkg -i [file name]
to uninstall:	sudo dpkg -r [name of the packge]

apt-get is better for shell using
apt is better for direct user using but not big difference between them
bothe apt-get and apt are stable api's ' for installing software witj dependencies on linux4
 it will check the repositories stored at /etc/apt/sources.list or sources.list.d for third party repositories
 to update the source list we use: apt-get update
 to install: apt-get install (packge namge)
 to install package without other recommende but unnessery packges can use : apt-get install --no-install-reccomends (packge name)
 
 system upgrade:
 	sudo apt upgrade
 or: sudo apt upgrade --with-new-pkgs (will install all possible updates and enven install new dependencies if needed)
 



====== NETWORKS ====

IP command

We can use it to show our network configuration:
► ip addr show
ifconfig -a (will do the same but differntly. older program)

The software: Wireshark
► In this chapter, we will use the software Wireshark to inspect
network traffic
► This is a GUI application, but it really allows us to visualize what's
happening on our network
► Before we continue, let's install this application on our system:
► apt install wireshark
	sudo wireshark
	
 == Layer one: Disable device ===
► We can also disable a device through software
► We first need to get the name of our device:
► ip
addr show
► After this, we can enable / disable the device:
► ip link set dev <interface> up
► ip link set dev <interface> down
► Example:
► ip link set dev enp0s5 down

We can show information about our network devices with the
following command:
► ip addr show


==== layer 3: How to set IP address   ====
► We can also use the tool ip to manage IP addresses:
► List IP address(es):
► ip
addr show
► Add an IP address to an interface:
► ip
addr add <ip_address>/<prefix_length> dev <interface>
► Remove an IP address from an interface:
► ip
addr del <ip_address>/<prefix_length> dev <interface>
► Example:
► ip addr add 192.168.1.10/24 dev enp0s5


=== Inspecting routes ===
► How to we list routes?
► Show the routing table:
► ip route show
► Display details for a specific route:
► ip route get <destination>
► Example:
► ip route get 8.8.8.8
► Changing routes:
► Add a route:
► ip route add <destination> via <gateway> dev <interface>
► Remove a route:
► ip route del <destination> via <gateway> dev <interface>
► Example:
► ip route add 10.0.0.0/24 via 192.168.1.1 dev enp0s5


===how to inspect DHCP connection ===
On systems that use systemd to also manage their network, we
can just show the logs for this unit:
► journalctl
-u systemd-networkd
► This will allow us to inspect potential DHCP related problems on
our system

On systems that use NetworkManager to also manage their
network, we can just show the logs for this unit:
► journalctl
-u NetworkManager
► This will allow us to inspect potential DHCP related problems on
==- we can use -b for (from boot), -u is for unix


===== port scanner - Nmap ====

To scan a specific host:
► By default, it will scan the most common 1000 TCP ports
nmap [hostname/IP]
► We can also specify the port(s) manually:
► nmap-p [port] [hostname/IP]
► nmap-p [port1],[port2] [hostname/IP]
► nmap-p [port1]-[port2] [hostname/IP]
► To scan all ports:
► nmap -p - [hostname/IP]
► To scan a range of IP addresses:
► nmap[first IP]-[last IP (last number)]
► nmap192.168.1.1-100
