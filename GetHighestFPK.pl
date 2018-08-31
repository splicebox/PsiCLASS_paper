#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl FPK.list > max_FPK.list\n" if ( @ARGV == 0 ) ;

open FPlist, $ARGV[0] ;
my %transcriptFPK ;
my %transcriptOutput ;
while ( <FPlist> )
{
	chomp ;
	open FP1, $_ ;
	#print $_, "\n" ;
	while ( <FP1> )
	{
		chomp ;
		my $line = $_ ;
		my @cols = split ;
		#if ( $cols[0] eq "ENST00000439627.2" )
		#{
		#	print $line, "\n" ;
		#}
		if ( !( defined $transcriptFPK{ $cols[0] } ) || $transcriptFPK{ $cols[0] } < $cols[4] )
		{
			$transcriptFPK{ $cols[0] } = $cols[4] ;
			$transcriptOutput{ $cols[0] } = $line ;
		}
	}
	close FP1 ;
}

foreach my $val (values %transcriptOutput )
{
	print $val, "\n" ;
}
