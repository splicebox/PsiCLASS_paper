#!/bin/sh

if [ $1 = "correlation" ]
then
	echo -n > correlation_summary.out
	for t in class stringtie scallop cufflinks
	do
		../grader sim_chr2.gtf ${t}/${t}_01_chr2.gtf -M > /dev/null
		cor=`perl ComputeAbundanceCorrelation.pl ${t}/${t}_01_chr2.gtf grader.recall ../../data/sim/sim_abundance.out`
		echo $t $cor >> correlation_summary.out
	done
fi

if [ $1 = "voten" ]
then
	echo -n > voten_summary.out
	for n in {1..25}
	do
		../grader sim_chr2.gtf vote_cutoff/classes_vote_${n}.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo $n $recall $precision >> voten_summary.out
	done
fi

if [ $1 = "fratio" ]
then
	echo -n > fratio_summary.out
	for t in class stringtie cufflinks
	do
		for cutoff in 0 0.01 0.05 0.1 0.2 0.5
		do
			../grader sim_chr2.gtf fratio_cutoff/${t}_${cutoff}.gtf -M | grep " 1\.000" > tmp.out
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`
			echo $t $cutoff $recall $precision >> fratio_summary.out
		done
	done
fi

if [ $1 = "cov" ]
then
	echo -n > cov_summary.out
	for t in class stringtie scallop
	do
		for cutoff in 0.01 0.5 1 2.5 5 10 25 50
		do
			../grader sim_chr2.gtf cov_cutoff/${t}_${cutoff}.gtf -M | grep " 1\.000" > tmp.out
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`
			echo $t $cutoff $recall $precision >> cov_summary.out
		done
	done
fi

if [ $1 = "lowmedhigh" ]
then
	echo -n > lowmedhigh_summary.out
	for t in class stringtie scallop cufflinks	
	do
		echo $t
		for level in low med high
		do
			../grader sim_chr2_${level}.gtf $t/${t}_01_chr2.gtf -M | grep " 1\.000" > tmp.out
			recall=`head -1 tmp.out | cut -f3 -d' '`
			precision=`tail -1 tmp.out | cut -f3 -d' '`
			echo $t $level $recall >> lowmedhigh_summary.out
		done
	done

	for level in low med high
	do
		../grader sim_chr2_${level}.gtf classes_sample_0.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`
		echo classes $level $recall >> lowmedhigh_summary.out
	done
fi

if [ $1 = "classes" ]
then
prefix=classes_star
echo -n > ${prefix}_recall.out
echo -n > ${prefix}_precision.out
for i in {0..24}
do
	#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
	echo $i
	../grader sim_chr2.gtf ${prefix}/${prefix}_sample_$i.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`

	#echo $recall, $precision
	echo $i $recall >> ${prefix}_recall.out
	echo $i $precision >> ${prefix}_precision.out
done
exit

prefix=classes
echo -n > ${prefix}_recall.out
echo -n > ${prefix}_precision.out
for i in {0..24}
do
	#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
	echo $i
	../grader sim_chr2.gtf ${prefix}_sample_$i.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`

	#echo $recall, $precision
	echo $i $recall >> ${prefix}_recall.out
	echo $i $precision >> ${prefix}_precision.out
done
fi

# stringtie merge
if [ $1 = "stmerge" ]
then
echo -n > stmerge_summary.out
for t in class stringtie scallop cufflinks
do
	ls ${t}/${t}_[0-9]*.gtf > tmp.list
	stringtie --merge tmp.list > stmerge_results/stmerge_${t}.gtf
	../grader sim_chr2.gtf stmerge_results/stmerge_${t}.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`
	echo ${t} $recall $precision >> stmerge_summary.out
	
	ls ${t}/${t}_star_[0-9]*.gtf > tmp.list
	stringtie --merge tmp.list > stmerge_results/stmerge_${t}_star.gtf
	../grader sim_chr2.gtf stmerge_results/stmerge_${t}_star.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`
	echo ${t}_star $recall $precision >> stmerge_summary.out

done
fi

# taco
if [ $1 = "taco" ]
then
echo -n > taco_summary.out
for t in class stringtie scallop cufflinks
do
	opt=""
	if [ $t = "scallop" ]
	then
		opt="--gtf-expr-attr RPKM"	
	fi

	ls ${t}/${t}_[0-9]*.gtf > tmp.list
	rm -r taco_${t}
	python ~/Softwares/taco-0.7.3/build/lib.linux-x86_64-2.7/taco_run.py -o taco_${t} $opt tmp.list
	perl ~/Tools/SortGTFByTid.pl taco_${t}/assembly.gtf > taco_results/taco_${t}.gtf
	../grader sim_chr2.gtf taco_results/taco_${t}.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`
	echo ${t} $recall $precision >> taco_summary.out
	
	ls ${t}/${t}_star_[0-9]*.gtf > tmp.list
	rm -r taco_${t}_star
	python ~/Softwares/taco-0.7.3/build/lib.linux-x86_64-2.7/taco_run.py -o taco_${t}_star $opt tmp.list
	perl ~/Tools/SortGTFByTid.pl taco_${t}_star/assembly.gtf > taco_results/taco_${t}_star.gtf
	../grader sim_chr2.gtf taco_results/taco_${t}_star.gtf -M | grep " 1\.000" > tmp.out
	recall=`head -1 tmp.out | cut -f3 -d' '`
	precision=`tail -1 tmp.out | cut -f3 -d' '`
	echo ${t}_star $recall $precision >> taco_summary.out
done
fi

if [ $1 = "single" ]
then
for t in cufflinks #class stringtie scallop cufflinks
do
	prefix=${t}
	echo -n > ${prefix}_recall.out
	echo -n > ${prefix}_precision.out
	for i in 0{1..9} {10..25}
	do
		#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
		../grader sim_chr2.gtf ${t}/${t}_${i}_chr2.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`

		#echo $recall, $precision
		echo $i $recall >> ${prefix}_recall.out
		echo $i $precision >> ${prefix}_precision.out
	done

	prefix=${t}_star
	echo -n > ${prefix}_recall.out
	echo -n > ${prefix}_precision.out
	for i in 0{1..9} {10..25}
	do
		#echo "../grader sim_chr2.gtf ${t}/${t}_chr2.gtf | grep \" 1\.000\" > tmp.out"
		../grader sim_chr2.gtf ${t}/${t}_star_${i}_chr2.gtf -M | grep " 1\.000" > tmp.out
		recall=`head -1 tmp.out | cut -f3 -d' '`
		precision=`tail -1 tmp.out | cut -f3 -d' '`

		#echo $recall, $precision
		echo $i $recall >> ${prefix}_recall.out
		echo $i $precision >> ${prefix}_precision.out
	done
done
fi
