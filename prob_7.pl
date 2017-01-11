#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

my @primes = ();
my @nums = (2...200000);
say "Enter limit";
my $limit = <STDIN>;
chomp $limit;

while (scalar @primes < $limit)
{
	for(my $i = 1 ; $i < scalar @nums ; $i++)
	{
		if($nums[$i] % $nums[0] == 0)
		{
			splice @nums,$i,1;
		}
	}
			push @primes, shift @nums;
}
#say @primes;
if($primes[$limit-1] == undef)
{
	say "$limit th prime number is out of range";
	}
	else
	{
		say "$limit th prime number is $primes[$limit-1]";
	}