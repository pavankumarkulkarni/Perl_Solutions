#!/usr/bin/perl;
use strict;
use warnings;
use 5.010;

my $t = time;
my @seq = (0..190000);
# 2 digit = 90 =>180 characters
# 3 digit = 990 => 2970 characters
# 4 digit = 9990 => 39960 characters
# 5 digit = 99990 => 499950 characters
# 6 digits half
my $s = join('',@seq);
my @arr = split('',$s);
say scalar @arr;
say $arr[1]*$arr[10]*$arr[100]*$arr[1000]*$arr[10000]*$arr[100000]*$arr[1000000];
say "$arr[1] -- $arr[10] -- $arr[100] -- $arr[1000] -- $arr[10000] -- $arr[100000] -- $arr[1000000]";
say "Time for execution is " ,time-$t;