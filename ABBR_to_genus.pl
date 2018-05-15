#!/usr/bin/perl -w
use strict;

my(@abbr, @ge);


open FI , '<' , $ARGV[0];
open SI , '<' , $ARGV[1];


while (<SI>){
	chomp;
	my($ge , $abbr) = (split /,/)[4 , 9];
	push @ge , $ge;
	push @abbr , $abbr;
}


while (<FI>){
	chomp;
	my $sp = (split /,/)[0];
	$sp =~ s/\A\.\///;
	
	for my $i (0..$#abbr){
		if ($abbr[$i] eq $sp){
			mkdir "$ge[$i]" , 0755 or warn "Cannot make directory: $!" unless (-e $ge[$i]);
			system "cp -r ../genomes/$sp $ge[$i]/";
		}
	}

}


close FI;
close SI;
