#!/usr/bin/perl -w
use strict;


my $content = `find . -mindepth 1 -maxdepth 1 -type d`;
my @root = split /\n/, $content;


foreach my $root (@root){
	chdir "$root";
	my $spall = `find . -mindepth 1 -maxdepth 1 -type d`;
	my @dir = split /\n/, $spall;
	system "egaz template @dir --self -o ../../self/$root/ --circos --length 200 --parallel 4 -v";
	chdir '../';
}
