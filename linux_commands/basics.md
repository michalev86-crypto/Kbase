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

