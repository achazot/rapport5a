#!/bin/bash

errors=$(cat $1 | grep error | grep '^./')

if [ -n "$errors" ]; then
	echo $errors
	linen=$(echo $errors | sed 's/^[^:]*://g' | sed 's/:.*//')
	filen=$(echo $errors | sed 's/:.*//')
	estr=$(cat -n $filen | grep "^ *$linen")
	echo -e "\033[0;31mhere: $estr \033[0m"
	echo ""
	exit 1
fi
