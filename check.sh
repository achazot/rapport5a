#!/bin/bash

errors=$(cat $1 | grep error | grep '^./')

if [ -n "$errors" ]; then
	echo $errors
	linen=$(echo $errors | sed 's/^[^:]*://g' | sed 's/:.*//')
	filen=$(echo $errors | sed 's/:.*//')
	estr=$(cat -n $filen | grep "^ *$linen")
	echo -ne "\033[0;31mhere: \033[0m"
	echo $estr
	echo ""
	exit 1
fi
