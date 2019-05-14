#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;
my $start = time;
my $num;
my @sequence = ();
my $max_num = 0;
my @max_seq = ();
my %hash;

for(my $n = 2; $n <100000; $n++){
	$num = $n;
	if(!exists$hash{$num}){
		while($num!=1){
			push(@sequence,$num);
			$hash{$num}=1;
			if($num%2 == 0){
				$num/=2;
			}else{
				$num = 3*$num+1;
			}
		}
	}
#say "Max number is $n";
#say "Sequence count is -> ",scalar @sequence;
#say join('->',@sequence);
#say ;	
	if(scalar @sequence > scalar @max_seq){
		$max_num = $n;
		@max_seq = @sequence;
	}
	@sequence = ();
}

say "Max number is $max_num";
say "Sequence count is -> ",scalar @max_seq;
say join('->',@max_seq);
say "Time for execution is --- > ",time-$start;