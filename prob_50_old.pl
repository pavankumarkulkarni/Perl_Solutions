#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $now = time;

my %primes;
$primes{1}=2;
my $prime_cnt = 1;
my $nat_num = 3;
my $t1;
my @tr_pr =();
my $tr_sum = 0;
while(scalar @tr_pr <= 10){
	my $cnt =1;
	my $flag = 'Y';
	while(sqrt($nat_num) >= $primes{$cnt}){
		if(($nat_num % $primes{$cnt}) == 0){
			$nat_num++;
			$flag = 'N';
			last;
		}
		$cnt++;
	}
	if($flag eq 'Y') {
		$prime_cnt++;
		$primes{$prime_cnt} = $nat_num;
		my @primes_tem = values %primes;
			if(trun_prim($nat_num,@primes_tem) eq 'Y'){
				push(@tr_pr,$nat_num);
				$tr_sum += $nat_num;
				say $nat_num;
			}; 	
				$nat_num++;			
		}	
}

say 'total primes are ',$prime_cnt;
say $primes{$prime_cnt};
say time - $now;


say '11 truncatable primes are';
say join('-',@tr_pr);
say 'Their sum is --',$tr_sum;


sub trun_prim{
	my @arr = @_;
	my $p_n = shift @arr;
	#say join('-',@arr);
	say $p_n;	
	return 'N' if length($p_n) == 1;
	return 'N' if $p_n%10 =~ m/[1,4,6,8,9]/;
	return 'N' if substr($p_n,length($p_n)-1,1) =~ m/[1,4,6,8,9]/;
	my %prim_rev = reverse %primes;	
	for(my $i = 0; $i <= length($p_n)-1 ; $i++){
		my $num = substr($p_n,length($p_n)-1-$i,$i+1);
		my $num1 = substr($p_n,0,$i+1);
		if(!(exists $prim_rev{$num})){
			return 'N';
			}
		if(!(exists $prim_rev{$num1})){
			return 'N';
			}			
	}
#	for(my $i = length($p_n)-1; $i >=0 ; $i--){
#		my $num = substr($p_n,0,length($p_n)-$i);
#		say "***********",$num;
#		if(!(exists $prim_rev{$num})){
#			return 'N';
#			}
#	}
	return 'Y';
}