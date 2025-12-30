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
