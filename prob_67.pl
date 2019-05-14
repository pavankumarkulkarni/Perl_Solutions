#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;

my $file_name = "p067_triangle.csv";
open my $fh, '<' , $file_name or
	die  "Can't open the file";

my @data;
while(my $line = <$fh>){
	chomp($line);
	push(@data,[split(' ',$line)]);
}
my $max_rows = scalar @data - 1;

for(my $r = $max_rows-1; $r >= 0; $r--){
	my $len = scalar @{$data[$r]}-1;
	for my $item (0..$len){
		my $rr = $r+1;
		my $it = $item+1;
		$data[$r][$item] = 
			$data[$r][$item] + $data[$rr][$item] > $data[$r][$item] + $data[$rr][$it] 
			? $data[$r][$item] + $data[$rr][$item] :  $data[$r][$item] + $data[$rr][$it];
	}
}

say "Maximum sum path is $data[0][0]";
say "Time taken for execution is ", time - $t;
