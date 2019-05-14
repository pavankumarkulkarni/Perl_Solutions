#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::BigInt;
use Math::BigInt::Calc;

my %hash;
my @arr = ();
my $n ;#= Math::BigInt-> new("2");
my $i ;#= Math::BigInt-> new("2");
my $j ;#=Math::BigInt-> new("2");
my $cnt =0;
for($i = 2 ; $i <=100 ; $i++){
	for( $j = 2 ; $j <=100 ; $j++){
		$n = $i**$j;
		my $m = sprintf "%.0f", $n;
		say $m;
		$hash{$m} = 1;
		$cnt++;
	}
}

@arr = keys %hash;
@arr = sort @arr;
#say join('-',@arr);
say scalar @arr;
#say $cnt;
