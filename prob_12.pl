#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my @result;
my $t=0;
my $nu_div=0;

while($nu_div < 1001){
	my $t1 = tri_num();
	if($t == $t1){
		say "Maximum number in perl reached $t";
		exit;
		}
	$t = $t1;
	if($t%2 == 1){
		next;
		}
	@result=num_divisors($t);
	my $nu_div1 = shift @result;
	if($nu_div1 > $nu_div){
		say "number of divisores",$nu_div;
		$nu_div = $nu_div1;
		}
}	

say "Triagonal number is $t";
say "number of divisores",$nu_div;
say "Numbers are ---",join('|',@result);

sub tri_num{
	state $n= 0;
	$n++;
	state $lst_tr=0;
	$lst_tr += $n;
	return $lst_tr;
}

sub num_divisors{
	my ($n) = @_;
	my $num_divs =0;
	my @arr;
	for(my $i = 1;$i <= sqrt($n) ; $i++){
		if($ n%$i == 0){
			$num_divs+=1;
			push @arr,$i;
			if($i != ($n/$i)){
				$num_divs+=1;
				push @arr,$n/$i;
			}
		}
	}
	return $num_divs,@arr;
}