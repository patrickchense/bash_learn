#!/bin/bash

number=1

set -x
if [ $number = "1" ]; then
	echo "number = 1"
else
	echo "number != 1"
fi

set +x


