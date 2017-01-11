#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

say "Enter limit";
my $limit = <STDIN>;
chomp $limit;

#Generate seriese of primes upto limit
my @primes = ();
my @srs = (2...$limit);

#say join('-',@srs);
while(scalar @srs > 0)
{
	for(my $i = 1 ; $i < scalar @srs ; $i++)
	{
		if($srs[$i] % $srs[0] == 0)
		{
			splice @srs,$i,1;
		}
	}
			push @primes, shift @srs;
}
#say join('-', @primes);

my %prim_rep;
my @rep;
my @rep_tem;
for(my $i=0;$i< scalar @primes;$i++)
{
	$prim_rep{$primes[$i]}=0;
	$rep[$i] = 0;
	$rep_tem[$i] =0;
}

#say %prim_rep;

my $lim_temp = $limit;
while($lim_temp > 1)
{
	@rep_tem = cmd($lim_temp,@primes);
	for(my $i = 0 ; $i<scalar @primes ; $i++)
	{
		if($rep[$i] < $rep_tem[$i])
		{
			$rep[$i] = $rep_tem[$i]
		}
	}
#	say $lim_temp;
#	say @rep_tem;
#	say @rep;
	$lim_temp --;
}

#say join('-',@rep);
#say join('-',@primes);
my $div=1;
for(my $i = 0 ; $i < scalar @rep ; $i++)
{
	if($rep[$i]>0)
	{
#		say "$primes[$i] should be multiplied $rep[$i] times";
		$div = $div*$primes[$i]**$rep[$i];
#		say $primes[$i];
#		say $rep[$i];
	}
}

say "Smallest number divisible by numbers from 1 to $limit is -- $div";

		sub cmd()
		{
		my $num = $_[0];
		my @rep;
		for (my $i = 1 ; $i < scalar @_; $i++)
		{
			$rep[$i-1] = 0;
		}
		#say @rep;
		while($num >1)
		{
			for(my $i = 1;$i < scalar @_ ; $i++)
			{
				if($num % $_[$i] == 0)
				{
					$num = $num/$_[$i];
					$rep[$i-1]++;
					last;
				}
			}
		}
		#say @rep;
		return @rep;
		}