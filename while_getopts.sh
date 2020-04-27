#!/bin/bash

while getopts 'lha:' OPTION; do
	case "$OPTION" in
		l)
			echo " config l"
			;;
		h)
			echo " config h"
			;;
		a)
			avalue="$OPTRAG"
			echo "The val provided is $OPTRAG"
			;;
		?)
			echo "script usage: $(basename $0) [-l] [-h] [-a someval] >&2"
			exit 1
			;;
	esac
done

