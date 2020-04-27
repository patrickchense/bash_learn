#!/bin/bash

function alice {
	echo "alice: $@"
	echo "$0: $1 $2 $3 $4"
	echo "$# arguments"
}

alice in wonderland

function log_msg {
	echo "[`date '+ %F %T'` ]: $@"
}

log_msg "This is sample log msg"

function func_return_val {
	return 10
}

func_return_val
echo "Val returned by func: $?"

fn () {
	local foo
	foo=1
	echo "fn: foo = $foo"
}
fn
echo "global: foo = $foo"


