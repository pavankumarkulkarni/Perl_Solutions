#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $st_tm = time;
#say "Enter limit";
my $limit = 400000;

#Generate seriese of primes upto limit
my @primes = ();
my @srs = (2...$limit);
my $prim_sum = 0;
#say join('-',@srs);
my $t1=0;
my @tr_pr=();
my $tr_sum = 0;
while(scalar @tr_pr <11)
{
	for(my $i = 1 ; $i < scalar @srs ; $i++)
	{
		if($srs[$i] % $srs[0] == 0)
		{
			splice @srs,$i,1;
		}
	}
			$t1 = shift @srs;
			say $t1;
			push(@primes,$t1);
			if(trun_prim($t1,@primes) eq 'Y'){
				push(@tr_pr,$t1);
				$tr_sum += $t1;
			}; 
}

say '11 truncatable primes are';
say join('-',@tr_pr);
say 'Their sum is --',$tr_sum;
say time-$st_tm;

sub trun_prim{
	my @arr = @_;
	my $p_n = shift @arr;
	#say join('-',@arr);
	return 'N' if length($p_n) == 1;
	for(my $i =0; $i< length($p_n); $i++){
		my $num = substr($p_n,$i,length($p_n)-1);
#		say "------",$num;
		if(!($num~~@arr)){
			return 'N';
			}
	}
	for(my $i =0; $i< length($p_n); $i++){
		my $num = substr($p_n,0,length($p_n)-$i);
#		say "***********",$num;
		if(!($num~~@arr)){
			return 'N';
			}
	}
	return 'Y';
}