#!/usr/bin/perl -w
use strict;


my (	$mit_content	,
	$chl_content	,
	@mit_name	,
	@chl_name	); 


chdir "$ARGV[0]" or die "Can't chdir to $ARGV[0]: $!";
$mit_content = `find . -mindepth 1 -maxdepth 1 -type d `;


chdir "$ARGV[1]" or die "Can't chdir to $ARGV[1]: $!";
$chl_content = `find . -mindepth 1 -maxdepth 1 -type d `;

@mit_name = split /\n/, $mit_content;
@chl_name = split /\n/, $chl_content;


foreach my $mit (sort @mit_name){
	$mit =~ s/\A\.\/(\w+)/$1/;
	$mit =~ s/([a-zA-Z])([a-zA-Z])[a-zA-Z]+_(\w+)/$1$2_$3/ if ( $mit =~ m/_/ );
}


foreach my $chl (sort @chl_name){
	$chl =~ s/\A\.\/(\w+)/$1/;
	$chl =~ s/([a-zA-Z])([a-zA-Z])[a-zA-Z]+_(\w+)/$1$2_$3/ if ( $chl =~ m/_/ );
	foreach my $mit (@mit_name){
		print "$chl\n" if $mit eq $chl;
	}
}
