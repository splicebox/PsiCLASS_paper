#!/bin/sh

# split the reference annotation.
perl ../SplitSimRefByGeneTxpt.pl ../sim_chr2.gtf sim_chr2_genetxpt


PSICLASS=../classes/classes_vote.gtf
ST=../stmerge_results/stmerge_stringtie.gtf
SCALLOP=../taco_results/taco_scallop.gtf

../../grader ../sim_chr2.gtf $PSICLASS -M > /dev/null
perl ../SplitGTFBySimGeneTxpt.pl ../sim_chr2.gtf $PSICLASS grader.precision classes

../../grader ../sim_chr2.gtf $ST -M > /dev/null
perl ../SplitGTFBySimGeneTxpt.pl ../sim_chr2.gtf $ST grader.precision stringtie

../../grader ../sim_chr2.gtf $SCALLOP -M > /dev/null
perl ../SplitGTFBySimGeneTxpt.pl ../sim_chr2.gtf $SCALLOP grader.precision scallop
