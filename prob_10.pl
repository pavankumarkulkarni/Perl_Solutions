#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $limit = 2000000;
my $sum_primes = 2;
my $flag = 'Y';
for(my $i = 3 ; $i <$limit; $i ++){
	$flag ='Y';
	for(my $j = 2 ; $j <= sqrt($i);$j++){
		if($i%$j == 0){
			$flag = 'N';
			last;
		}
	}
	if($flag eq 'Y'){
		$sum_primes += $i;
	}
}

say "Sum of primes till $limit is ",$sum_primes;