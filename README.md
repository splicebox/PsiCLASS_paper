PsiCLASS_paper
=======

Scripts, commands and data used in the manuscript:

Song, L., Sabunciyan, S., and Florea, L. (2018). A multi-sample approach increases the accuracy of transcript assembly, *Submitted*.

	Copyright (C) 2018- and GNU GPL by Li Song, Liliana Florea


## Commands for running the tools:
PsiCLASS: Assume the bam files are listed in the file "bamlist"

	psiclass --lb bamlist

StringTie (v1.3.3b):

	stringtie ${bamfile} > stringtie_out.gtf

Scallop (v0.10.2):

	scallop -i ${bamfile} -o scallop_out.gtf

StringTie-merge (v1.3.3b): Assume the GTF files are listed in the file "gtflist"
	
	stringtie --merge gtflist > stmerge_out.gtf

TACO (v0.7.3): Assume the GTF files are listed in the file "gtflist"

	python taco_run.py -o taco_out gtflist
	perl SortGTFByTid.pl taco_out/assembly.gtf > taco_out.gtf

HISAT2 (v2.0.5): For the mouse data set we use the mm10 genome and index. For the simulated data set, since the files are in fasta format, we need to add the option "-f" to hisat2

	hisat2 -p 6 -x ~/hg38_index/hisat2/hg38 -1 ${file1} -2 ${file2} | samtools view -b - > ${prefix}.unsorted.bam
	samtools sort --threads 6 -m 2G -o ${prefix}.bam ${prefix}.unsorted.bam

STAR (v2.5.3a):

	STAR --outSAMstrandField intronMotif --runThreadN 6 --genomeDir ~/hg38_index/star/ --readFilesIn ${file1} ${file2} --outSAMtype BAM Unsorted --outFileNamePrefix ./star/sample${i}_ --readFilesCommand zcat 
	samtools sort --threads 6 -m 2G -o star/star_${prefix}.bam star/sample${i}_Aligned.out.bam

Evaluation scripts for each data set are in the bash file evaluation_${dataset}.sh

## Commands related to simulated data

### Generate the simulated data with Polyester

Select the expressed transcripts from the GENCODE v27 annotation

	awk '{if ($3=="exon" && $3=="transcript") print;}' gencode.v27.annotation.gtf > gencode_v27.gtf
	perl chooseTxpt.pl gencode_v27.gtf > sim.gtf
	perl ExtractAnnotationFaFromGTF.pl gencode.v27.transcripts.fa sim.gtf > sim_transcripts.fa


Obtain Polyester through "git clone" instead of library installation in R

	Rscript run_polyester.R   

### Categorize the transcripts based on expression level

Generate the FPK for each sample:

	#!/bin/sh

	for i in {01..25}
	do
	        echo $i
		perl GetSimAbundance.pl sim.gtf sim_results/sample_${i}_1.fasta.gz > sim_abundance_${i}.out
	done

Get the max FPK for each sample across the samples:

	perl GetHighestFPK.pl sim_abundance_out.list > max_FPK.out

Split the annotation into three categories (low, med, high)

	perl SplitSimRef.pl sim_chr2.gtf max_FPK.out sim_chr2

## Commands for plotting

The plots are generated through the commands in plot/plot.R. 

The data for the plots is also in the directory plot.

## Availability of GTF files generated in the manuscript

## Availability of raw data (fasta/fastq, BAM files)
