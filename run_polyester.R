library(polyester)
library(Biostrings)

simulate_experiment( 'sim_transcripts.fa', num_reps=c(25), fold_change=matrix(c(1), nrow=1), meanmodel = TRUE, outdir='sim_results' ) 
