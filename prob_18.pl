#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;

my $file_name = "prob_18_data.csv";
open my $fh, '<' , $file_name or
	die  "Can't open the file";

my @data;

while(my $line = <$fh>){
	chomp($line);
	push(@data,[split(' ',$line)]);
}
my $max_rows = scalar @data - 1;
say join('|',@{$data[$max_rows]});

for(my $r = $max_rows-1; $r >= 0; $r--){
	my $len = scalar @{$data[$r]}-1;
	for my $item (0..$len){
		my $rr = $r+1;
		my $it = $item+1;
		my $t1 = $data[$r][$item] + $data[$rr][$item];
		my $t2 = $data[$r][$item] + $data[$rr][$it];		
		if($t1 > $t2){
			$data[$r][$item] = $t1;
		}else{
			$data[$r][$item] = $t2;
		}
	}
}

say "Maximum sum path is $data[0][0]";