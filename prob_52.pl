#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $now = time;

my $nat_num = 1;
my $flag = 'N';
while($flag eq 'N'){
	my $str1 = num_str($nat_num);
	my $n2 = 2*$nat_num;
	my $n3 = 3*$nat_num;
	my $n4 = 4*$nat_num;
	my $n5 = 5*$nat_num;	
	my $n6 = 6*$nat_num;
	my $str2 = num_str($n2);
	if($str1 eq $str2){
		my $str3 = num_str($n3);	
		if($str2 eq $str3){
			my $str4 = num_str($n4);	
			if($str3 eq $str4){
				my $str5 = num_str($n5);		
				if($str4 eq $str5){
					my $str6 = num_str($n6);		
					if($str5 eq $str6){
						$flag = 'Y';
						last;
						}
					}
				}
			}
		}
		$nat_num++;
}

say "Number is ",$nat_num;
say "Execution time is ",time - $now;

sub num_str{
	my $n = $_[0];
	my $len = length($n);
	my @arr = ();
	for(my $i =0; $i < $len; $i++){
		push(@arr,substr($n,$i,1));	
	}
	@arr = sort(@arr);
#	say join('-',@arr);
	return join('-',@arr);
}