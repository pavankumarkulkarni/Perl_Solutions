#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $data_file = '20BY20.txt';
open my $fh, '<', $data_file
	or die 'Can\'t open file $_';
my %metric;
my $row = 0;
while(my $line = <$fh>){
	chomp $line;
	my @temp_line = split(' ',$line);
	for(my $col = 0; $col < scalar @temp_line; $col++){
		$metric{$row, $col} = $temp_line[$col];
		}
	$row++;
	
}
#Horizontal multiplication of 4 adjuscent numbers
my ($r, $c) = (0,0);
my $hor_lar_mul=0;
my @hor_start = (0,0);
my @nums_hor;
while(exists $metric{$r,$c+3}){
	while(exists $metric{$r,$c+3}){
		my $temp = $metric{$r,$c} * $metric{$r,$c+1} * $metric{$r,$c+2} * $metric{$r,$c+3};
		if($temp > $hor_lar_mul){
			$hor_lar_mul = $temp;
			@hor_start = ($r, $c);
			@nums_hor=($metric{$r,$c}, $metric{$r,$c+1}, $metric{$r,$c+2}, $metric{$r,$c+3});			
		}
		$c++
	}
	$c=0;
	$r++;
}	
	#say $hor_lar_mul;
	#say join('-',@hor_start);

#Vertical multiplication of 4 adjuscent numbers
my ($r, $c) = (0,0);
my $ver_lar_mul=0;
my @ver_start = (0,0);
my @nums_ver;
while(exists $metric{$r+3,$c}){
	while(exists $metric{$r+3,$c}){
		my $temp = $metric{$r,$c} * $metric{$r+1,$c} * $metric{$r+2,$c} * $metric{$r+3,$c};
		if($temp > $ver_lar_mul){
			$ver_lar_mul = $temp;
			@ver_start = ($r, $c);
			@nums_ver =($metric{$r,$c}, $metric{$r+1,$c}, $metric{$r+2,$c}, $metric{$r+3,$c});
		}
		$c++
	}
	$c=0;
	$r++;
}	
	#say $ver_lar_mul;
	#say join('-',@ver_start);
#Diagonal multiplication of 4 adjuscent numbers
my ($r, $c) = (0,0);
my $dia_lar_mul=0;
my @dia_start = (0,0);
my @nums_dia;
while(exists $metric{$r+3,$c+3}){
	while(exists $metric{$r+3,$c+3}){
		my $temp = $metric{$r,$c} * $metric{$r+1,$c+1} * $metric{$r+2,$c+2} * $metric{$r+3,$c+3};
		if($temp > $dia_lar_mul){
			$dia_lar_mul = $temp;
			@dia_start = ($r, $c);
			@nums_dia =($metric{$r,$c}, $metric{$r+1,$c+1}, $metric{$r+2,$c+2}, $metric{$r+3,$c+3});
		}
		$c++
	}
	$c=0;
	$r++;
}	
#	say $dia_lar_mul;
	#say join('-',@dia_start);	
#Diagonal multiplication of 4 adjuscent numbers
my ($r, $c) = (0,19);
my $dia_lar_mul_2=0;
my @dia_start_2 = (0,0);
my @nums_dia_2;
while(exists $metric{$r+3,$c-3}){
	while(exists $metric{$r+3,$c-3}){
		my $temp = $metric{$r,$c} * $metric{$r+1,$c-1} * $metric{$r+2,$c-2} * $metric{$r+3,$c-3};
		if($temp > $dia_lar_mul_2){
			$dia_lar_mul_2 = $temp;
			@dia_start_2 = ($r, $c);
			@nums_dia_2 =($metric{$r,$c}, $metric{$r+1,$c-1}, $metric{$r+2,$c-2}, $metric{$r+3,$c-3});
		}
		$c--;
	}
	$c=19;
	$r++;
}	
#	say $dia_lar_mul_2;
#	say join('-',@dia_start_2);		
my $lar_mul;
my @start;
my @num;
my $pattern;
if(($hor_lar_mul > $ver_lar_mul) && ($hor_lar_mul > $dia_lar_mul ) && ($hor_lar_mul > $dia_lar_mul_2 )){
	$lar_mul = $hor_lar_mul;
	@start = @hor_start;
	@num = @nums_hor;
	$pattern = 'Horizontal';
} elsif (($ver_lar_mul>$dia_lar_mul)&&($ver_lar_mul>$hor_lar_mul)&&($ver_lar_mul>$dia_lar_mul_2)){
	$lar_mul = $ver_lar_mul;
	@start = @ver_start;
	@num = @nums_ver;	
	$pattern = 'Vertical';	
} elsif( ($dia_lar_mul_2>$ver_lar_mul)&&($dia_lar_mul_2> $hor_lar_mul)&& ($dia_lar_mul_2>$dia_lar_mul) ) {
	$lar_mul = $dia_lar_mul_2;
	@start = @dia_start_2;
	@num = @nums_dia_2;	
	$pattern = 'Reverse Diagonal  ';	
}else{
	$lar_mul = $dia_lar_mul;
	@start = @dia_start;
	@num = @nums_dia;	
	$pattern = 'Diagonal ';	
}

say "Largest multiplication of 4 adjustcent numbers is $lar_mul";
say "numbers are ", join('-',@num);
say "$pattern  -- Starting position is ", join('-',@start);

close $fh	
	or die 'Can\'t close file $_';