#!/bin/sh

if [ $1 = "samplesize" ]
then
	echo -n > samplesize_summary.out
	# classes.
	for i in 1 10 20 40 80 160 320 667
	do
		../../grader ../gencode.v27.annotation.gtf samplesize/classes_${i}/classes_vote.gtf -M | grep " 1\.000" > tmp.out 
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		
		echo classes $i $recall $precision >> samplesize_summary.out
	done

	# stringtie, scallop.
	for t in stringtie scallop
	do
		for i in 1 10 20 40 80 160 320 667
		do
			../../grader ../gencode.v27.annotation.gtf $t/stmerge_${i}.gtf -M | grep " 1\.000" > tmp.out 
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`
			
			echo ${t}_stmerge $i $recall $precision >> samplesize_summary.out
		done
	done


	for t in stringtie scallop
	do
		for i in 1 10 20 40 80 160 320 667
		do
			../../grader ../gencode.v27.annotation.gtf $t/taco_${i}.gtf -M | grep " 1\.000" > tmp.out 
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`
			
			echo ${t}_taco $i $recall $precision >> samplesize_summary.out
		done
	done
fi
