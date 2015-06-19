#!/bin/bash

t=1
for i in `cat $1`
do
	if test $t -eq 1; then
		t=0
		echo $i
	else
		t=1
	fi
done