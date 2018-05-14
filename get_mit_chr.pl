#! /usr/bin/perl -w
use strict;


open IN , '<', $ARGV[0];


while (<IN>){
	chomp;
	my( $chl , $mit ) = split /,/; 
	system "mkdir -p ~/data/organelle/common/genomes/$chl/";
	system "cp $ARGV[1]/$chl/NC* ~/data/organelle/common/genomes/$chl/";
	system "cp $ARGV[2]/$mit/NC* ~/data/organelle/common/genomes/$chl/";
}

