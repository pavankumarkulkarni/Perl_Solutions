#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $data_file = 'p13data.txt';

open my $fh, '<', $data_file;

my %dt;
my ($i,$j)=(0,0);
my $max_col;
while(my $line = <$fh>){
	chomp $line;	
	$line =~ s/\s//g;
#	say length($line);
	$max_col =  length($line);
	for ($j = 0 ; $j < $max_col; $j++){
		$dt{$i, $j} = substr($line,$max_col - $j-1,1);
	}
	$i++;
}
my $max_rows = $i-1;

my %int_sum;
my $tem_sum =0;
for($j = 0 ; $j < $max_col ; $j++){
	for($i = 0 ; $i <= $max_rows ; $i++){
		$tem_sum+=$dt{$i,$j};
#		print $dt{$i,$j};
#		say $tem_sum;
	}
	$int_sum{0,$j} = $tem_sum;	
	$tem_sum =0;
}

#for($j = 0 ; $j < $max_col ; $j++){
#	say $int_sum{0,$j};
#}

my $carry =0;
my $tem = 0;
my @result=();
for($j=0;$j<$max_col;$j++){
	$tem = $int_sum{0,$j} + $carry;
	push(@result,substr($tem,length($tem)-1,1));
	$carry = substr($tem,0,length($tem)-1);
	#say $carry;	
}
	push(@result, $carry);
	say reverse @result;