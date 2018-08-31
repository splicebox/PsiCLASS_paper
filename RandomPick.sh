#!/bin/sh

ln=`wc -l $1 | cut -f1 -d' '`
for i in {1..35}
do
	pick=$(($RANDOM % $ln + 1))
	echo $pick
done
