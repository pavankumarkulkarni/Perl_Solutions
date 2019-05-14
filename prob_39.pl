#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my %hash;
my %hash_det;
my $file_name = 'prob_39_results.csv';
open my $fh,'>',$file_name or
	die "Can't open the file";
for(my $a = 1; $a <= 1000; $a++){
	for(my $b = 1; $b <= 1000-$a; $b++){
		my $c;
			$c = sqrt($a**2+$b**2);
			if($c == int($c)){
				if($a+$b > $c){
					my $p = $a+$b+$c;
					if($p<=1000){
						my $s = $a.'-'.$b.'-'.$c;			
						if(exists $hash{$p}){
							$hash{$p}++;
							my $t = $hash_det{$p}.'||'.$s;							
							$hash_det{$p} = $t;
						}else{
							$hash{$p}=1;
							my $t = $hash_det{$p}.'||'.$s;							
							$hash_det{$p} = $t;
						}				
					}
				}			
			}
		}
	}
my $max_sol=0;
my $par;
for my $p (keys %hash){
	print $fh "Perimeter $p has solutions ",$hash_det{$p},"\n";
	if($hash{$p} > $max_sol){
		$max_sol = $hash{$p};
		$par = $p;
	}
}

say "Maximum number of solutions are $max_sol for perimeter $par";


say "Time for execution is " ,time-$t;