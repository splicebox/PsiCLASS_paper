#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl sim.gtf sim_read.fa.gz\n" if ( @ARGV == 0 ) ;

my %transcriptLength ;
my %transcriptFrag ;
my %transcriptChr ;

open FP1, $ARGV[0] ;
my $tid = "" ;
my $length ;
while ( <FP1> )
{
	chomp ;
	my $line = $_ ;
	my @cols = split /\s+/, $line ;
	if ( $cols[11] =~ /"(.+)?";/ )
	{
		$tid = $1 ;
	}
	#print $tid, "\n" ;
	if ( $cols[2] eq "transcript" )
	{	
		$transcriptFrag{ $tid } = 0 ;
		$transcriptLength{ $tid } = 0 ;
		$transcriptChr{ $tid } = $cols[0] ;
	}
	else
	{
		$transcriptLength{ $tid } += $cols[4] - $cols[3] + 1 ;
	}
}
close FP1 ;

open FP1, "zcat ".$ARGV[1]." |" ;
while ( <FP1> )
{
	next if ( !/^>/ ) ;
	chomp ;
	my $line = $_ ;
	$tid = ( split /[\|\/]/, $line )[1] ;
	#print $tid, "\n" ;
	if ( defined $transcriptFrag{ $tid } )
	{
		++$transcriptFrag{ $tid } ;
	}
}
close FP1 ;

foreach my $key (keys %transcriptLength )
{
	print $key, " ", $transcriptChr{ $key }, " ", $transcriptFrag{ $key }, " ", $transcriptLength{ $key }, " ", $transcriptFrag{ $key } / ( $transcriptLength{ $key } / 1000.0 ), "\n" ;
}
