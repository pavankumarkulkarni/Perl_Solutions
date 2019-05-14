#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $now = time;

my @primes = (2,3,5,7);
my $nat_num =10;
my @cir_primes = (2,3,5,7);
while($nat_num < 1000000){
	if(!($nat_num =~m/[0,2,4,6,8]/g)){
		if(is_prime($nat_num) eq 'Y'){
			push(@primes,$nat_num);
			if(is_cir_prime($nat_num) eq 'Y'){
				push(@cir_primes,$nat_num);
				}
			}
	}
	$nat_num++;
}
my $fname = 'pp_35.txt';
open my $fh, '>',$fname or
	die "Cant open the file $_";
print $fh "Cicular primes are \n";
for my $p (@cir_primes){
	print $fh $p,"\n";
}
say scalar @cir_primes;
say "time taken for execution --",time-$now;
sub is_prime{
	my $n = $_[0];
	for (my $i=2 ; $i <= sqrt($n)+1;$i++){
		if($n%$i == 0){
			return 'N';
			}
		}
		return 'Y';
}

sub is_cir_prime{
	my $n = $_[0];
	my $len = length($n);
	my $m = $n;
	for(my $i=0 ; $i < $len-1 ; $i++){
		my $tem = substr($m,1,$len-1).substr($m,0,1);
		$m = $tem;
		if(is_prime($m) eq 'N'){
			return 'N';
		}
	}
	return 'Y';
}