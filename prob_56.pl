#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::BigInt;
my $now = time;
my $nat_num = Math::BigInt -> new('1');
my $sum = 0;
my $i;
my $j;
for(my $a = Math::BigInt -> new('1'); $a < 100; $a++){
	for(my $b = Math::BigInt -> new('1'); $b < 100; $b++){
		$nat_num = $a**$b;
		#say $nat_num;
		my $t = dig_sum($nat_num);
		if( $t > $sum){
			$i = $a;
			$j = $b;
			$sum = $t;
			}
		say "\$a $a -- \$b $b -- $sum";			
		}
	}

say "Largest sum of digits is $sum";
say "$i to the power $j";
say "Execution time ", time - $now;


sub dig_sum{
	#my $n = Math::BigInt -> new($_[0]);
	my $n = $_[0];
	my $len = length($n);
#	say $len;
	my $sum = 0;#Math::BigInt -> new(0);
	for(my $i=0; $i < $len; $i++){
		$sum += $n%10;
		$n = int($n/10);
	}
	return $sum;
}