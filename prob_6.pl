#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

say " Enter the limit";
my $limit = <STDIN>;
chomp $limit;

my $sum_sqaures = 0;
my $squares_sum = 0;

my $limit_tem = $limit;
while($limit_tem > 0)
{
	$sum_sqaures = $sum_sqaures + $limit_tem*$limit_tem;
	$squares_sum = $squares_sum + $limit_tem;
	$limit_tem--;
}

$squares_sum = $squares_sum*$squares_sum;

say "Sum of squares is $sum_sqaures";
say "Squares of sum is $squares_sum";
say "Difference is ", $squares_sum-$sum_sqaures;