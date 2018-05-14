#!/usr/bin/perl -w
use strict;


my (	$mit_content	,
	$chl_content	,
	@mit_name	,
	@chl_name	,
	@mit_cname	,
	@chl_cname	); 


chdir "$ARGV[0]" or die "Can't chdir to $ARGV[0]: $!";
$chl_content = `find . -mindepth 1 -maxdepth 1 -type d `;


chdir "$ARGV[1]" or die "Can't chdir to $ARGV[1]: $!";
$mit_content = `find . -mindepth 1 -maxdepth 1 -type d `;


@mit_name = split /\n/, $mit_content;
@chl_name = split /\n/, $chl_content;


for my $i (0..$#mit_name){
	$mit_cname[$i] = $1 if $mit_name[$i] =~ m/\A\.\/(\w+)/;
	$mit_cname[$i] =~ s/([a-zA-Z])([a-zA-Z])[a-zA-Z]+_(\w+)/$1$2_$3/ if ( $mit_name[$i] =~ m/_/ );
		
}


for my $i (0..$#chl_name){
	$chl_cname[$i] = $1 if $chl_name[$i] =~ m/\A\.\/(\w+)/;
	$chl_cname[$i] =~ s/([a-zA-Z])([a-zA-Z])[a-zA-Z]+_(\w+)/$1$2_$3/ if ( $chl_cname[$i] =~ m/_/ );
		
	for my $j (0..$#mit_cname){
		print "$chl_name[$i],$mit_name[$j]\n" if $mit_cname[$j] eq $chl_cname[$i];
	}
}



