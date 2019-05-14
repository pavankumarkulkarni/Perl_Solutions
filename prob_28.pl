#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my $sum_dia = 0;
for(my $n=3; $n <= 1001; $n = $n+2){
	$sum_dia += $n**2;
	$sum_dia += $n**2-($n-1);
	$sum_dia += $n**2-2*($n-1);	
	$sum_dia += $n**2-3*($n-1);	
}
$sum_dia++;
say "Sum diagonals is -- $sum_dia";
say "Time taken for execution is ", time - $t;
