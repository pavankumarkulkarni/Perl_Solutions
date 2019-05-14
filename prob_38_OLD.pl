#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my $num;
my $pan_digit;
my @seq;
my $N;
$num = 1;
#987654321/2;
while($num < (987654321/2)){
	my @tem = gen_pandigit($num);
	#say join('|',@tem);
	if($pan_digit < $tem[0]){
		$pan_digit = $tem[0];
		$N = $num;
		@seq = (1..$tem[1]);
say "One of the pandigit number is $pan_digit";
say "It is Product of $N and ",join(',',@seq);		
	}
	$num++;
	}

say "Largest pandigit number is $pan_digit";
say "Product of $N and ",join(',',@seq);
say "Time for execution is ",time-$t;

sub gen_pandigit{
	my $n = $_[0];
	my $str;
	my $cnt = 1;
	while(length($str)<9){
		$str = $str.($n*$cnt);
		$cnt++;	
	}
	return 0 if length($str) > 9;
	return ($str,$cnt-1) if is_pan($str) eq 'Y';
}

sub is_pan{
	my $s = $_[0];
	my %h;
	for(my $i =0;$i <9;$i++){
		my $c = substr($s,$i,1);
		if($c==0){
			return 'N';
		}elsif(exists $h{$c}){
			return 'N';
		}else{
			$h{$c}=1;
		}
	}
	return 'Y';
}