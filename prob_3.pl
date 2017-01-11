#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Math::Round;

my $tar = 600851475143;

my $limit = round(100000);
say $limit;
my @is_prime = (2...$limit);
my @prime = (1);
while(scalar @is_prime > 0)
{
	for(my $i = 1; $i < scalar @is_prime ; $i++)
	{
		if($is_prime[$i] % $is_prime[0] == 0)
		{
			splice @is_prime,$i,1;
		}
	}
	push(@prime, shift @is_prime);
}
say $prime[scalar @prime -1];
say scalar @prime;
my $c =1;
my $lar=1;

while($lar < $tar)
{
for(my $c = 1;$c < scalar @prime;$c++)
	{
		if($tar % $prime[$c] == 0)
		{
			say $prime[$c];
			$tar = $tar/$prime[$c];
			if($prime[$c] > $lar)
			{
				$lar = $prime[$c];
				say "New target $tar";
				say "Prime factor $lar";
			}
		}
	}
}	

say "Largest prime factor of 600851475143 is $lar";