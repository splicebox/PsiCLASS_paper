#!/usr/bin/env perl

use strict ;
use warnings ;

die "usage: a.pl in.gtf out_prefix" if ( @ARGV != 2 ) ;

my $prefix = $ARGV[1] ;
open FP1, $ARGV[0] ;
#chr2	HAVANA	transcript	218780	260708	.	-	.	gene_id "ENSG00000035115.21"; transcript_id "ENST00000479739.6"; gene_type "protein_coding"; gene_name "SH3YL1"; transcript_type "nonsense_mediated_decay"; transcript_name "SH3YL1-222"; level 2; protein_id "ENSP00000441266.1"; transcript_support_level "2"; havana_gene "OTTHUMG00000151359.8"; havana_transcript "OTTHUMT00000322358.3";
my %geneTxptCnt ;
while ( <FP1> )
{
	chomp ;	
	my @cols = split /\s+/ ;
	next if ( $cols[2] ne "transcript" ) ;
	my $tid ;
	my $gid ;
	if ( $cols[11] =~ /"(.+)?";/ )
	{
		$tid = $1 ; 
	}
	if ( $cols[9] =~ /"(.+)?";/ )
	{
		$gid = $1 ;
	}
	++$geneTxptCnt{$gid} ;
}
close FP1 ;

open FPone, ">${prefix}_g1.gtf" ;
open FPtwo, ">${prefix}_g2.gtf" ;
open FPmore, ">${prefix}_g3.gtf" ;

open FP1, $ARGV[0] ;
while ( <FP1> )
{
	my $line = $_ ;
	my @cols = split /\s+/ ;
	my $gid ;

	if ( $cols[9] =~ /"(.+)?";/ )
	{
		$gid = $1 ;
	}
	
	my $tcnt = $geneTxptCnt{ $gid } ;
	if ( $tcnt == 1 )
	{
		print FPone $line ; 
	}
	elsif ( $tcnt == 2 )
	{
		print FPtwo $line ;
	}
	elsif ( $tcnt > 2 )
	{
		print FPmore $line ;
	}
	else
	{
		die "$gid bad count.\n"
	}
}
close FP1 ;

close FPone ;
close FPtwo ;
close FPmore ;
