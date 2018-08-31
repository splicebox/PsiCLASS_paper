#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl sim_ref.gtf sim_abundance.out prefix\n" if ( @ARGV == 0 ) ;

my %transcriptFPK ;
open FP1, $ARGV[1] ;
while ( <FP1> )
{
	chomp ;
	my @cols = split ;
	$transcriptFPK{ $cols[0] } = $cols[4] ;
}
close FP1 ;

open FP_low, ">".$ARGV[2]."_low.gtf" ;
open FP_med, ">".$ARGV[2]."_med.gtf" ;
open FP_high, ">".$ARGV[2]."_high.gtf" ;

open FP1, $ARGV[0] ;
my $tid ;
while ( <FP1> )
{
	chomp ;
	my $line = $_ ;
	my @cols = split /\s+/, $line ;
	if ( $cols[11] =~ /"(.+)?";/ )
	{
		$tid = $1 ;
	}
	
	if ( $transcriptFPK{ $tid } < 30 )
	{
		print FP_low "$line\n" ;	
	}
	elsif ( $transcriptFPK{ $tid } < 500 ) 
	{
		print FP_med "$line\n" ;
	}
	else
	{
		print FP_high "$line\n" ;
	}
}
close FP1 ;
