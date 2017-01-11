#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

my @all_values = (1,2);
my $i = 2;
my $tot = 0;
#say $all_values[scalar @all_values -1];
while($all_values[scalar @all_values -1] <= 4000000)
	{
		push @all_values,($all_values[$i-2]+$all_values[$i-1]);
		$i+=1;
		}

$i = scalar @all_values -1;
for(my $count = 0;$count < scalar @all_values; $count++)
{
	if ($all_values[$count] % 2 ==0)
		{
			$tot+=$all_values[$count];
			}
}
say $tot;