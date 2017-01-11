#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
my $a, $b;
my $i;
my $j;
my $k;
for($a = 1; $a< 1000; $a++)
{
	for($b =1;$b < 1000; $b++)
	{
		if(sqrt($a*$a+$b*$b) +$a + $b == 1000 )
		{
			$i = $a;
			$j = $b;
			$k = sqrt($a*$a + $b*$b);	
			last;
		}
	}
}

say "Answer is ",$i*$j*$k;