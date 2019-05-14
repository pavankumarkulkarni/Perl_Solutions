#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $now = time;
my $nat_num = 3;
my @arr = ();
while($nat_num < 10000000){
	if(dig_fact($nat_num) eq 'Y'){
		push(@arr,$nat_num);
	}
	$nat_num++;	
}
say join('-',@arr);
my $fname = 'pp_34.txt';
open my $fh, '>',$fname or
	die "Cant open the file $_";
print $fh "Digit factorials are \n";

say "time taken for execution --",time-$now;


sub fact{
	my $n = $_[0];
	return 1 if $n<=1;
	return 2 if $n==2;
	return $n*fact($n-1);
}

sub dig_fact{
	my $num = $_[0];
	my $ln = length($num);
	my $sum = 0;
	for(my $i=0;$i < $ln ; $i++){
		my $n = substr($num,$i,1);
		my $f = fact($n);
		$sum += $f;
#		say $sum;
		if($sum > $num){
			return 'N';
			}
	}
	if($sum == $num){
		return 'Y';
		}else{
			return 'N';
			}
}