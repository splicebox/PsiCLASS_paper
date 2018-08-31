PsiCLASS_paper
=======

The scripts and commands used in the manuscript:

Song, L., Sabunciyan, S., and Florea, L. (2018). A multi-sample approach increases the accuracy of transcript assembly, *Submitted*.

	Copyright (C) 2018- and GNU GPL by Li Song, Liliana Florea


## Commands of running different tools:
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

The evaluation scripts for each data set is in the bash file evaluation_${dataset}.sh

## Commands related to simulated data set

### Generate the simulated data with Polyester

Select the expressed transcripts from Gencode v27 annotation

	awk '{if ($3=="exon" && $3=="transcript") print;}' gencode.v27.annotation.gtf > gencode_v27.gtf
	perl chooseTxpt.pl gencode_v27.gtf > sim.gtf
	perl ExtractAnnotationFaFromGTF.pl gencode.v27.transcripts.fa sim.gtf > sim_transcripts.fa


Obtain Polyester through "git clone" instead of library installation in R

	Rscript run_polyester.R   

### Categorize the transcripts based on expression level

## Availability of GTF files generated in the manuscript

## Availability of raw data (fasta/fastq, BAM files)
