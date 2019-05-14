#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::BigInt;
my $now = time;
my $nat_num = Math::BigInt -> new('1');
#my $nat_num =1;
my @arr = ();
my $file1 = 'pp_55_neg.txt';
my $file2 = 'pp_55_pos.txt';
my $lcnt = 0;
open my $fh1, '>', $file1
	or die "Can't open file $!";
open my $fh2, '>', $file2
	or die "Can't open file $!";	
while($nat_num < 10000){	
	@arr = lychr_num($nat_num);
	if($arr[0] eq 'Y'){
		print $fh1 "$nat_num produced palindrome @ iteration ", $arr[1], " and the sum is $arr[2]\n";
	}else{
		print $fh2 "Number $nat_num is Lynchron\n";
		$lcnt++;
		}
	$nat_num++;
}

say "Number of Lychrons below 10000 is $lcnt";
close $fh1;
close $fh2;
say "Execution time ", time - $now;
sub lychr_num{
	my $n = $_[0];
	my $m;
	my $sum;
	my $rev_sum;
	my $cnt = 0;
	my $flag = 'N';
	while($cnt < 25){
		$m = rev_num($n);
		$sum = $n+$m;
		$rev_sum = rev_num($sum);
		$cnt++;
		if($sum == $rev_sum){
			$flag = 'Y';
			last;
		}
		$n = $sum;
	}
	my @arr = ($flag,$cnt,$sum);
	return @arr;
}

sub rev_num{
	#my $n = Math::BigInt -> new($_[0]);
	my $n = $_[0];
	my $len = length($n);
#	say $len;
	my $rev = Math::BigInt -> new(0);
	for(my $i=0; $i < $len; $i++){
		$rev = $rev*10+$n%10;
		$n = int($n/10);
	}
	return $rev;
}