#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $num = 9;
my $sum =0;
my @arr;

do{
	$num++;
	my $ln = length($num);
	my $t=0;
	for(my $i = 0; $i < $ln; $i++){
		$t += substr($num,$i,1)**5;
		}
	$sum = $t;
	if($sum == $num){
		push(@arr,$num);
		}
	}while($num<10000000);
say 'Numbers are --',join('-',@arr);	
$sum = 0;
for my $t (@arr){
	$sum +=$t;
}
say 'Sum --',$sum;	
	
		