#!/bin/sh

ref=./mm10_refseq.gtf

if [ $1 = "classes" ]
then
	prefix=classes
	echo -n > ${prefix}_summary.out
	for i in {0..43}
	do
		#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
		echo $i
		../grader $ref ${prefix}/${prefix}_sample_$i.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`

		#echo $recall, $precision
		echo $i $recall $precision >> ${prefix}_summary.out
	done
fi

# stringtie merge
if [ $1 = "stmerge" ]
then
	echo -n > stmerge_summary.out
	for t in class stringtie scallop
	do
		echo $t
		ls ${t}/${t}_*.gtf > tmp.list
		stringtie --merge tmp.list > stmerge_results/stmerge_${t}.gtf
		../grader $ref stmerge_results/stmerge_${t}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo ${t} $recall $precision >> stmerge_summary.out
	done
fi

# taco. Need python/2.7.9
if [ $1 = "taco" ]
then
	echo -n > taco_summary.out
	for t in class stringtie scallop
	do
		opt=""
		if [ $t = "scallop" ]
		then
			opt="--gtf-expr-attr RPKM"	
		fi

		ls ${t}/${t}_*.gtf > tmp.list
		rm -r taco_${t}
		python ~/Softwares/taco-0.7.3/build/lib.linux-x86_64-2.7/taco_run.py -p 8 -o taco_${t} $opt tmp.list
		perl ~/Tools/SortGTFByTid.pl taco_${t}/assembly.gtf > taco_results/taco_${t}.gtf
		../grader $ref taco_results/taco_${t}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo ${t} $recall $precision >> taco_summary.out
	done
fi

if [ $1 = "single" ]
then
	for t in class #stringtie scallop 
	do
		prefix=${t}
		echo $t
		echo -n > ${prefix}_summary.out
		for i in `cat control.list epilepsy.list`
		do
			echo $i
			#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
			../grader $ref ${t}/${t}_${i}.gtf -M | grep " 1\.000" > tmp.out
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`

			#echo $recall, $precision
			echo $i $recall $precision >> ${prefix}_summary.out
		done
	done
fi
