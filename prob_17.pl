#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;
use feature qw(switch);
my $len = 0;
for(my $i=1 ;$i <1001 ; $i++){
	my $single = $i%10;
	my $tenth = ($i/10)%10;
	my $hundred = int($i/100)%10;
	my $thousand = int($i/1000);
	my $sin_wrd = sub_sing($tenth,$single);
	my $ten_wrd = sub_ten($tenth,$single);
	my $hun_wrd = sub_hun($hundred,$tenth,$single);
	my $tho_wrd = sub_ths($thousand,$tenth,$single);
	my $wr= $tho_wrd.$hun_wrd.$ten_wrd.$sin_wrd;
	say $wr;
	$len += length($wr);
}

say "Length of all words is ---> ",$len;
sub sub_sing{
	my $m = $_[0];
	my $n = $_[1];
	if($m!=1){
		given($n)
		{
			when(1) { return 'one';}
			when(2) { return 'two';}	
			when(3) { return 'three';}
			when(4) { return 'four';}	
			when(5) { return 'five';}
			when(6) { return 'six';}	
			when(7) { return 'seven';}
			when(8) { return 'eight';}	
			when(9) { return 'nine';}
		}
	}
}
sub sub_ten{
	my $m = $_[0];
	my $n = $_[1];
	if($m==1){
		given($n){
			when(1) { return 'eleven';}
			when(2) { return 'twelve';}	
			when(3) { return 'thirteen';}
			when(4) { return 'fourteen';}	
			when(5) { return 'fifteen';}
			when(6) { return 'sixteen';}	
			when(7) { return 'seventeen';}
			when(8) { return 'eighteen';}	
			when(9) { return 'nineteen';}			
			when(0) { return 'ten';}				
			}
		}else{
			given($m){
				when(2) { return 'twenty';}	
				when(3) { return 'thirty';}
				when(4) { return 'forty';}	
				when(5) { return 'fifty';}
				when(6) { return 'sixty';}	
				when(7) { return 'seventy';}
				when(8) { return 'eighty';}	
				when(9) { return 'ninety';}							
			}
		}
	}
sub sub_hun{
	my $m = $_[0];
	my $n = $_[1];
	my $o = $_[2];	
	my $wrd ='';
	if($m!=0){
		$wrd = sub_sing(0,$m);
		if(($n==0) && ($o ==0))	{
				$wrd = $wrd.'hundred';
			}else{
				$wrd = $wrd.'hundredand';
			}
			return $wrd;
	}
	return;
}
sub sub_ths{
	my $n = $_[0];
	given($n)
	{
		when(1) {return 'onethousand'}
	}

}