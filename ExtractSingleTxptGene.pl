#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl xxx.gtf > yyy.gtf" if ( @ARGV == 0 ) ;

my %geneTxptCnt ;

open FP1, $ARGV[0] ;
while ( <FP1> )
{
	my @cols = split ;
	next if ( $cols[2] ne "transcript" && $cols[2] ne "stop_codon" ) ;
	my $geneId = $cols[9] ;
	++$geneTxptCnt{ $geneId } ;
}
close FP1 ;

open FP1, $ARGV[0] ;
while ( <FP1> )
{
	my $line = $_ ;
	my @cols = split ;
	my $geneId = $cols[9] ;
	if ( defined $geneTxptCnt{$geneId} && $geneTxptCnt{ $geneId } == 1 )
	{
		print $line ;
	}
}
close FP1 ;
