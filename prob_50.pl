#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $now = time;

my @primes = (2);
my @sum_of_primes = (2);
my @is_sum_prime=('Y');

my $nat_num =3;
my $sum = 2;
my $cnt = 1;
my $limit = 1000000;

#Generate and store all primes till 1M
while($nat_num <= $limit){
	if(is_prime($nat_num) eq 'Y'){
		$primes[$cnt] = $nat_num;
		$cnt++;
	}
	$nat_num++;
}

#get largest sequence number starting with each prime num
#say join('-',@primes);

#write down largest sequence starting with each prime
my $file_name = 'PP_50_result.txt';
open my $fh, '>', $file_name or
	die "cant open file $_";
print $fh "start_prime  sequence_count   prime_num \n";

my ($start_num ,$seq_count, $lar_prime) = (0,0,0);
for(my $i = 0 ;$i < scalar @primes-1 ;$i++){
	my ($start_num_tem,$seq_count_tem,$lar_prime_tem) = big_seq($i);
	print $fh "$start_num_tem----$seq_count_tem-----$lar_prime_tem\n";
	if($seq_count_tem > $seq_count){
		($start_num,$seq_count,$lar_prime) = ($start_num_tem,$seq_count_tem,$lar_prime_tem);
	}
}

say "$start_num---$seq_count---$lar_prime";

say "Execution time is ",time - $now;

sub big_seq{
	my $start_index = $_[0];
	my $n = $start_index;
	my $st_prime = $primes[$start_index];
	my $sum =0;
	@sum_of_primes = ();
	@is_sum_prime = ();
	$sum_of_primes[$start_index]=$primes[$start_index];
	$is_sum_prime[$start_index] = 'Y';
	while($sum <$limit){
			$start_index++;
			my $start_index_1 = $start_index - 1;
			$sum = $primes[$start_index] + $sum_of_primes[$start_index_1];
			$sum_of_primes[$start_index] = $sum;
			if(is_prime($sum) eq 'Y'){
				$is_sum_prime[$start_index] = 'Y';
			}else{
				$is_sum_prime[$start_index] = 'N';
			}
	}			
#	say join('-',@sum_of_primes);
#	say join('-',@is_sum_prime);
	for(my $i = scalar @is_sum_prime-1 ; $i >=0 ; $i--){
		if(($is_sum_prime[$i] eq 'Y') && ($sum_of_primes[$i] <=$limit)){
#			say $st_prime,$i-$n ,$sum_of_primes[$i];
			return ($st_prime,$i-$n ,$sum_of_primes[$i]);
		}
	}
	return ($st_prime,0,0);		
}

sub is_prime{
	my $n = $_[0];
	for (my $i=2 ; $i <= sqrt($n)+1;$i++){
		if($n%$i == 0){
			return 'N';
			}
		}
		return 'Y';
}