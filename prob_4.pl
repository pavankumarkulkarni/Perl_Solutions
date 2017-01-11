#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::Round;

my $num = 876;

my %hash;
for (my $j =999; $j>99;$j--)
{
	for (my $i = 999; $i > 99 ; $i--)
	{
		$hash{"$i $j"} = $i*$j;
	}
	
}

my %rhash = reverse %hash;
#say $hash{'999 999'};
foreach my $val(sort {$b <=> $a} values %hash)
{
	#say $val;
	#say is_pali($val);
	if(is_pali($val) eq 'P')
	{
		say "Biggest Palindrome is $val";
		say $rhash{$val};
		exit;
	}
}

#say is_pali($num);

sub is_pali()
{
	my $num = shift;
	my $rev =0;
	my $hol = $num;
	my $i=1;

	while($num > 1)
	{
		$rev = $rev*10 + $num % 10;
		$num = ($num / 10);
	}
#say $rev;
	if ($rev == $hol)
	{
		return "P";
	}
	else
	{
		return "N";
	}
}