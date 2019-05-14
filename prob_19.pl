#!/user/bin/perl;
use strict;
use warnings;
use 5.010;

use Date::Day;


my $sum_sundays = 0;
my @sundays_first = ();
my $md =1;
for(my $year = 1901;  $year <=2000;$year++){
	for(my $month = 1;  $month <=12;$month++){
		my $result = &day($month,1,$year);
		if($result eq 'SUN'){
			$sum_sundays++;
			push(@sundays_first,"$year--$month");
			}
		}
	}
say "Total number of Sundays falling on 1st of month in 20th century is --",$sum_sundays;
say "the year/month are ",join('||',@sundays_first);