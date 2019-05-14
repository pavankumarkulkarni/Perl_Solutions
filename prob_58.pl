#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my (@all_dia)=(1);
my @primes;
my $n = 1;
do{
	$n = $n+2;
	my @delta_dia;
	my @delta_primes;
	push(@delta_dia,$n**2);
	push(@delta_dia,$n**2-($n-1));
	push(@delta_dia,$n**2-2*($n-1));	
	push(@delta_dia,$n**2-3*($n-1));	
	push(@all_dia,@delta_dia);
	@delta_primes = extract_prime(@delta_dia);
	push(@primes,@delta_primes);	
}while((scalar @primes)/(scalar @all_dia) >= 0.1);

say join('-',@all_dia);
say join('|',@primes);
say "Side length ",$n;

say "Time taken for execution is ", time - $t;


sub extract_prime{
	my @nums = @_;
	my @res;
	my $len = scalar @nums;
	for(my $i=0; $i < $len; $i++){
		my $n = $nums[$i];
		my $p = 'Y';
		for(my $j = 2; $j <= sqrt($n); $j++){
			if($n%$j == 0){
				$p = 'N';	
				last;
			}
		}
		push(@res,$n) if $p eq 'Y';
	}
	return @res;
}