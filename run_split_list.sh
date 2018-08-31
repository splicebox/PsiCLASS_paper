#!/bin/sh

l=`wc -l fastq-file-list.txt | cut -f1 -d' '`
echo $l
for i in `seq 1 80 $l`
do
	echo $i
	sed -n $i,$(($i+79))p fastq-file-list.txt > list_${i}.txt

	sbatch run_download_hisat2.scr list_${i}.txt 
done
