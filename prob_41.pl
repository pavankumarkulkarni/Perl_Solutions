#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;


my $fl = 'N';
my $pan_digit;
my @seq;
my $n;
my $z=1;
my $num = 987654321;
my $ii=1;
while(length($num)>0){
	my $cnt = 0;
	my $l = length($num);
	my $fct = fact($l);
	while($cnt < $fct){
		my $n = perm_num($cnt,$num);
		if(is_prime($n) eq 'Y'){
			say "Sr Number $ii --- pandigit prime is $n";
			$ii++;
			#exit;
		}
		$cnt++;
	}
	$num = substr($num,1,$l);
	#say $num;
}

say "Time for execution is ", time-$t;

sub perm_num{
	my $n = $_[0];
	my $m = $_[1];
	my @pos_arr;
	my @str = split('',$m);
	my $ret_str;
	my $l = length($m);
	for(my $i=$l-1;$i >=0 ;$i--){
		my $f = fact($i);
		my $c = int($n/$f);
		$n = $n%$f;
		push(@pos_arr,$c);	
	}
	for my $item (@pos_arr){
		my $c = $str[$item];
		splice(@str,$item,1);
		$ret_str = $ret_str.$c;
	}
	return $ret_str;
}


sub fact{
	my $n = $_[0];
	return 1 if $n <=1;
	return $n *fact($n-1);
}

sub is_prime{
	my $n = $_[0];
	return 'N' if $n < 2;
	for(my $i=2; $i <= sqrt($n);$i++){
		if($n%$i ==0){
			return 'N';
		}
	}
	return 'Y';
}