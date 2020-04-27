#!/bin/bash

number=0
while [ "$number" -lt 10 ]; do
	echo "Number = $number"
	number=$((number + 1))
done

number=0
until [ "$number" -ge 10 ]; do
	echo "Number = $number"
	number=$(( number + 1 ))
done

retry=0
until cp $1 $2 || [ $retry -gt 3 ]; do
	echo "Attempt $1 $2 failed.waiting..."
	retry=$(( retry + 1 ))
	echo "retry $retry"
	sleep 3
done

count=0
for i in $(cat ~/.bash_profile); do
	count=$(( count + 1 ))
	echo "Word count ($i) contains $(echo -n $i | wc -c) chars"
done

for input; do
	echo "input $input"
done

for (( i=0; i<5; i=i+1 )); do
	echo $i
done

for number in 1 2 3 4 5 6
do
	echo "number is $number"
	if [ "$number" = "3" ]; then
		break
	fi
done

while read -p "What file do you want to test?" filename
do
	if [ $filename == "quit" ]; then
	 	echo "quit"
		break
	elif [ ! -e "$filename" ]; then
		echo "The file does not exist"
		continue
	fi
	echo "You entered a valid file"
done


select brand in Samsung Sony iphone symhony Walton
do
	echo "You have chosen $brand"
	break
done

echo "Which Operating System do you like?"

select os in Ubuntu LinuxMint Window8 Window7 WindowsXP
do
	case $os in
		"Ubuntu" | "LinuxMint")
			echo "I also use $os"
			;;
		"Windows8" | "Windows10" | "WindowsXP")
			echo "Why don't you try Linux?"
			;;
		*)
			echo "Invalid entry"
			break
			;;
	esac
done


			
