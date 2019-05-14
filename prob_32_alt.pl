#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my %hash;
for(my $i=1; $i<= 9999; $i++){
	# min J. I.J.mu; = 9 digit. if I is 1 digit. J is 1 digit. min mul is also 1 digit.  
	# on same logic to get 9 digit, J has to be 4 digits so mul is also 4 digit and result is 9 digit.
	#if I is 5 digit, mul is also 5 digit minimum hence max num can't be 5 digits.since only one has to be counted in I*j and J*I same logic applies for J.
	# so I and J starts from 1 to 9999	
	if($i =~ m/0/g){ #skip if $i contains 0
		next;
	}
	my $l =5-length($i); # it turns out if $i is 1 character, j has to be 4 character. any other length does notproduce 9 character result.
	my $min_i = 1x$l;    # similarly if $i is 2 character, $j has to be 3 character. min is 1 repeated and max 9 repeated.
	my $max_i = 9x$l;
	for(my $j=$min_i; $j<= $max_i; $j++){
		my $mul = $i *$j;
		my $str = $i.$j.$mul;
		if($mul > 987654321){
			last;
		}
#		say "length ---",length($str);
#		say $str;
		if(length($str)!=9){
			next;
		}elsif(is_pandigit($str) eq 'Y'){
#			say $str;
			$hash{$mul}=1;		
			say $i , "  ",$j,"  ",$mul;
		}
	}
}
my @muls = keys %hash;
my $sum =0;
for my $mul (@muls){
	$sum += $mul;
}


say "Sum of products is $sum";
say "And the products are ",join('|',@muls);
say " Time for execution is ", time-$t;



sub is_pandigit{
	my $n = $_[0];
	my $l = length($n);
	my @arr = (1..$l);
	my %h;
	if($n=~m/0/g){
		return 'N';
		}
	for(my $i=0; $i < $l; $i++){
		my $c = substr($n,$i,1);
		if(exists $h{$c}){
			return 'N';
		}else{
			$h{$c}=1;
		}			
	}
	return 'Y' if scalar @arr == scalar keys %h;
	return 'N';
}