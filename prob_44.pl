#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my $i = 2;
my $flag= 'N';
while($flag <5){
	for(my $j = $i-1;$j > 0;$j--){
		my $num1 = $i*(3*$i-1)/2;
		my $num2 = $j*(3*$j-1)/2;	
		if(is_pentagonal($num1+$num2) & is_pentagonal($num1-$num2)){
			say "Difference is ",$num1-$num2;
			say "Indexes are ", $i, " and ",$j;
			$flag = 'Y';
			last;
		}
	}
	$i++;
}

say "Time for execution is ",time-$t;

sub is_pentagonal{  #inverse function to determine if a number is pentagonal
	my $n = $_[0];
	my $x = (sqrt(24*$n+1)+1)/6;
	return 1 if($x ==int($x));
	return 0;
}