#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::BigInt;

my $x = Math::BigInt-> new("2");

my $y= $x**1000;

my $tem_sum = 0;

for(my $i = 0 ;$i < length($y); $i++){
	$tem_sum += substr($y,$i,1);
}
say $tem_sum;
say $y;
