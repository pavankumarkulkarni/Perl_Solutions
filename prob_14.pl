#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my @sequence =();
my $max_num=2;
my @max_seq = (2,1);
my %hash;
my @ar = (1);
$hash{2}=[@ar];
#say @{$hash{2}};
my $num;
for(my $n = 2;$n < 100;$n++){
	$num = $n;
	while(!(exists($hash{$num}))){
			if($num%2 == 0) {
				$num = $num/2;
				push(@sequence,$num);
				}else{
					$num = 3*$num +1;
					push(@sequence,$num);		
				}
			}
	say $n;
	say join('->',@sequence);			
	push(@sequence,@{$hash{$num}});
	$hash{$n} = [@sequence];
	@sequence = ();
	if(scalar @{$hash{$n}} > scalar @max_seq){
		@max_seq = @{$hash{$n}};
		$max_num = $n;
	}
	}
	
say "Number is $max_num";
say "Sequence count is,",scalar @max_seq;
say join('->',@max_seq);
