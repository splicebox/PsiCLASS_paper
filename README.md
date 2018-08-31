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

StringTie-merge (v1.3.3b): Assume the gtf files are listed in the file "gtflist"
	
	stringtie --merge gtflist > stmerge_out.gtf

TACO (v0.7.3): Assume the gtf files are listed in the file "gtflist"

	python taco_run.py -o taco_out gtflist
	perl SortGTFByTid.pl taco_out/assembly.gtf > taco_out.gtf

## Commands related to simulated data set

### Generate the simulated data with Polyester

### Categorize the transcripts based on expression level
