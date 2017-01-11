#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

my @all_values = (1..999);
my $tot = 0;
foreach my $i (@all_values)
{
	if(($i%3 == 0) || ($i%5 ==0))
	{
		$tot+= $i;
	}
}
say $tot;