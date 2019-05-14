#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $noe =time;
my $p1 = 0;
my $p2 = 0;
my $p5 = 0;
my $p10 = 0;
my $p20 = 0;
my $p50 = 0;
my $p100 = 0;
my $p200 = 0;
my $cnt =0;
my @arr = ();
for($p200 = 0;$p200 <=1;$p200++){
	my $a = $p200*200;
	for($p100 = 0;$a + $p100*100 <= 200;$p100++){
		my $b = $a + $p100*100;
		for($p50 = 0;$b + $p50*50 <=200;$p50++){
			my $c = $b + $p50*50;
			for($p20 = 0;$c + $p20*20 <=200;$p20++){
				my $d = $c + $p20*20;
				for($p10 = 0; $d + $p10*10 <=200;$p10++){
					my $e = $d +$p10*10;
					for($p5 = 0;$e + $p5*5 <=200;$p5++){
						my $f = $e + $p5*5;
						for($p2 = 0;$f + $p2*2 <=200;$p2++){
							my $g = $f + $p2*2;
							for($p1 = 0;$g + $p1*1 <=200;$p1++){
								my $n = $p200*200 + $p100*100 + $p50*50 + $p20*20 + $p10*10 + $p5*5 + $p2*2 + $p1*1;
									if($n == 200){
										$cnt++;
										my $str = "$p200*200 + $p100*100 + $p50*50 + $p20*20+ $p10*10 +$p5*5 + $p2*2 + $p1*1";
										push(@arr,$str);
										}
									}
								}
							}
						}							
					}
				}
			}
		}
say "Count is -- ",$cnt;
#say join('+++',@arr);
my $fname = 'pp_31_resulr.txt';
open my $fh,'>',$fname or
	die 'Cant open file for writing $_';
print $fh 'Total count is ---',$cnt,"\n";
print $fh '##############################################################',"\n";
my $i=1;
for my $opt (@arr){
print $fh "Option-$i ----";
print $fh $opt;
print $fh "\n";
$i++;
}
close $fh;

say 'Time taken for execution',time-$noe;									

		