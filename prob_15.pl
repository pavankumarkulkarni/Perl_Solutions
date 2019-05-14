#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my ($r, $c) = (01,01);

my $path = path_count($r,$c);


sub path_count{
	my ($row,$col) = (@_);
	my $count=0;
	if(($row == 20) && ($col == 20)){
		return 1;
		}
	if($row > 0){
		$count = $count+path_count($row-1,$col);
	}
	if($row > 0){
		$count = $count+path_count($row,$col-1);
	}		
}