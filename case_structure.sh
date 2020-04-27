#!/bin/bash

echo -n "input one number between 1 to 3(include) > "
read char
case $char in
	1) echo 1 ;;
	2) echo 2 ;;
	3) echo 3 ;;
	*) echo 'input er'
esac

echo -n "input one number or char > "
read char
echo
case $char in
	[[:lower:]] | [[:upper:]] ) echo "input char: $char" ;;
	[0-9] ) echo "input number: $char" ;;
	*) echo 'input wrong'
esac

echo "try multiple match in case: end with ;;& not ;; "
echo "this funciton need bash 4.0, mac default is 3.2, upgrad https://itnext.io/upgrading-bash-on-macos-7138bd1066ba "
read -n 1 -p "input a char >"
echo
case $REPLY in
	[[:upper:]] ) echo "$REPLY is upper case" ;;
	[[:lower:]] ) echo "$REPLY is lower case" ;;
	[[:alpha:]] ) echo "$REPLY is a char" ;;
	*) echo "$REPLY is something" 
esac
echo "test result not working ? why ?"




