#!/bin/sh
filename=read_file_demo
while read myline
do 
	echo $myline
done < $filename
