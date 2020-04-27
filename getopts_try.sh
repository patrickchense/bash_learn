!#/bin/sh

while getopts 'lha:' OPTION; do
	case "$OPTION" in
		l)
			echo "config l"
			;;
		h)
			echo "config h"
			;;
		a)
			avalue="$OPTARG"
			echo "the val provided is $OPTARG"
			;;
		?)
			echo "usage: $(basename $0) [-l] [-h] [-a someval] " >&2
			exit 1
			;;
		esac
	done
	shift "$(($OPTIND - 1))"
