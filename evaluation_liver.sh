#!/bin/sh

ref=./gencode.v27.annotation.gtf

if [ $1 = "individual" ]
then
	for t in stringtie scallop
	do
		echo -n > ${t}_summary.out
		for s in `cat samplelist`
		do
			echo $t $s
			../grader gencode.v27.annotation.gtf $t/${t}_${s}.gtf -M | grep " 1\.000" > tmp.out
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`

			echo $s $recall $precision >> ${t}_summary.out
		done
	done
	
	t=classes 
	echo -n > ${t}_summary.out
	for s in {0..72}
	do
		echo $t $s
		../grader gencode.v27.annotation.gtf $t/${t}_sample_${s}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`

		echo $s $recall $precision >> ${t}_summary.out
	done
fi

if [ $1 = "voten" ]
then
	echo -n > voten_summary.out
	for n in {1..73}
	do
		../grader $ref vote_cutoff/classes_vote_${n}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo $n $recall $precision >> voten_summary.out
	done
fi

if [ $1 = "stmerge" ]
then
	echo -n > stmerge_summary.out
	for t in classes stringtie scallop
	do
		echo $t
		#stringtie --merge ${t}.gtflist > stmerge_results/stmerge_${t}.gtf
		../grader $ref stmerge_results/stmerge_${t}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo ${t} $recall $precision >> stmerge_summary.out
	done

fi

if [ $1 = "taco" ]
then
	echo -n > taco_summary.out
	for t in classes stringtie scallop
	do
		opt=""
		if [ $t = "scallop" ]
		then
			opt="--gtf-expr-attr RPKM"	
		fi

		#rm -r taco_${t}
		#python ~/Softwares/taco-0.7.3/build/lib.linux-x86_64-2.7/taco_run.py -p 8 -o taco_${t} $opt ${t}.gtflist
		#perl ~/Tools/SortGTFByTid.pl taco_${t}/assembly.gtf > taco_results/taco_${t}.gtf
		../grader $ref taco_results/taco_${t}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo ${t} $recall $precision >> taco_summary.out
	done

fi
