#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $dat_file = 'p022_names.txt';
my @names_arr =();
open my $fh,'<',$dat_file
	or die 'Cant open file $_';
while(my $line = <$fh>){
	$line =~ s/\"//g;
	@names_arr = split(',',$line);
}

@names_arr = sort @names_arr;
my $ar_ln = scalar @names_arr;
my $cnt = 0;
my $sum_names=0;
while($cnt < $ar_ln){
	my $name = $names_arr[$cnt] ;
	my $name_value = char_num($name);
	$sum_names += $name_value*($cnt+1);
	$cnt++;
}
say 'The crazy result is -- ',$sum_names;

sub char_num{
	my $name = $_[0];
	my $ln = length($name);
	my $chr;
	my $n;
	my $sum = 0;
	for(my $i=0;$i<$ln;$i++){
		$chr = substr($name,$i,1);
		$n = ord($chr);
		if($n > 96){
			$n = $n-96;
			}
			else{
				$n = $n-64;
				}
			$sum =$sum +$n;
		}
		return $sum;
}	