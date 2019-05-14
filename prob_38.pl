#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my $num = 987654321;
my $cnt = 0;
my $fl = 'N';
my $pan_digit;
my @seq;
my $n;
my $z=1;
while($cnt < 362880){
	my $n = perm_num($cnt);
	my @t = pan_digit($n) ;
	if( $t[0] ne 'N'){
		say "Number $z --- Pandigit number is $n and the common multiplier is $t[0] and the sequence is ",join(',',(1..$t[1]));
		$z++;
#		last;
	}
	$cnt++;
	}
say "Time for execution is ", time-$t;

sub perm_num{
	my $n = $_[0];
	my @pos_arr;
	my @str = split('',987654321);
	my $ret_str;
	for(my $i=8;$i >=0 ;$i--){
		my $f = fact($i);
		my $c = int($n/$f);
		$n = $n%$f;
		push(@pos_arr,$c);	
	}
	#say @pos_arr;
	#say @str;
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

sub pan_digit{
	my $n = $_[0];
	my $nn = $n;
	my $pos = 1;
	while($pos < 8){
		my $n1 = substr($nn,0,$pos);
		$nn =~s/$n1//;
		my $pan = 'Y';
		my $c = 2;
		while($pan eq 'Y'){
			my $div = $n1/1;
			my $n2 = $div*$c;
			#say $nn;
			#say $c;				
			if($nn =~m/^$n2/){
				$nn =~s/$n2//;		
			}else{
				$pan = 'N';
				#say 'exiting loop';
			}
			if(length($nn) == 0){
				return ($div,$c);
			}
			$c++;
		}
	$pos++;
	$nn = $n;
	}
	return 'N';
}