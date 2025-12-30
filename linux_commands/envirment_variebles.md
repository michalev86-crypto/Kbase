
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
