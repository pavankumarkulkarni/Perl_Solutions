#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my $file_name = 'p042_words.txt';
open my $fh, '<' , $file_name or
	die "can't open the file";
my $file_name1 = 'p042_solutions.txt';
open my $fh1, '>' , $file_name1 or
	die "can't open the file";
	
my @words;
my @sums;
while(my $line = <$fh>){
	chomp($line);
	$line =~ s/"//g;
	@words = split(',',$line);
}

#say join("|",@words);
for my $w (@words){
	my $l = length($w);
	my $s=0;
	for(my $i=0;$i < $l;$i++){
		my $c = substr($w,$i,1);
		$s += (ord($c)-64);
	}
	push(@sums,$s);
}
my $m=0;
my $c;
for my $i (0..scalar @sums-1){
	if($sums[$i] > $m){
		$m = $sums[$i];
		$c = $words[$i];	
		}
}
say $m, $c;
my @tri_num;
my $n = 1;
my $i=1;
while($n <= $m){
	$n = $i*($i+1)/2;
	push(@tri_num,$n);
	$i++;
}
my $tn=0;
for my $i (0..scalar @sums-1){
	if(grep {$_ == $sums[$i]} @tri_num){
		print $fh1 $words[$i]. " with corresponding triagonal number is " .$sums[$i]."\n";
		$tn++;
	}

}

say "Total number of triangular words are $tn";
say "Time for execution is " ,time-$t;