#!/usr/bin/perl
use strict;
use warnings;

my $days = 0;

my $year_current;    
my $endmonth;        
my $endday;          

my $year_birth;      
my $startmonth;      
my $startday;        
my @bith_day;
my @current_year;

&main;

sub read_in {
	my $checkInt;

	do {
		print "***************************\n";
		print "*Please enter day of birht*\n";
		print "***************************\n";
		$startday = <STDIN>;
		$checkInt = isinteger($startday);
		push( @bith_day, $startday );
	} until ( $checkInt == 1 );

	do {

		print "*****************************\n";
		print "*Please enter month of birth*\n";
		print "*****************************\n";
		$startmonth = <STDIN>;
		$checkInt   = isinteger($startmonth);
		push( @bith_day, $startmonth );
	} until ( $checkInt == 1 );

	do {
		print "****************************\n";
		print "*Please enter year of birth*\n";
		print "****************************\n";
		$year_birth = <STDIN>;
		$checkInt   = isinteger($year_birth);
		push( @bith_day, $year_birth );
	} until ( $checkInt == 1 );

	do {
		print "**************************\n";
		print "*Please enter current day*\n";
		print "**************************\n";
		$endday   = <STDIN>;
		$checkInt = isinteger($endday);
		push( @current_year, $endday );
	} until ( $checkInt == 1 );

	do {
		print "***************************\n";
		print "*Plese enter current month*\n";
		print "***************************\n";
		$endmonth = <STDIN>;
		$checkInt = isinteger($endmonth);
		push( @current_year, $endmonth );
	} until ( $checkInt == 1 );

	do {
		print "***************************\n";
		print "*Please enter current year*\n";
		print "***************************\n";
		$year_current = <STDIN>;
		$checkInt     = isinteger($year_current);
		push( @current_year, $year_current );
	} until ( $checkInt == 1 );

	chomp(
		$year_birth,   $startmonth, $startday,
		$year_current, $endmonth,   $endday
	);

}

sub main {
	&read_in;

	if ( $year_birth > $year_current ) {
		print "Incorect Details\n";					
		exit 0;	
	}
	else {

		if ( $year_birth == $year_current ) {
			$days =
			  numbers_of_days_between_startend_daymonth( $startmonth, $startday,
				$endmonth, $endday );
			print "Number of days lived: ", $days;
		}
		else {
			my $one = $endmonth;
			my $two = $endday;

			my $leapYear = &isLeapYear( $year_birth, $year_current );
			$days =
			  numbers_of_days_between_startend_daymonth( $startmonth, $startday,
				12, 31 ) +
			  numbers_of_days_between_startend_daymonth( 1, 1, $one, $two ) +
			  ( 365 * ( ( $year_current - $year_birth ) - 1 ) ) + $leapYear;

			chomp(@bith_day);
			chomp(@current_year);

			print "*Year of birth entred: ", ( join "/", @bith_day ),     "\n";
			print "*Current date entred:  ", ( join "/", @current_year ), "\n";
			print "*Number of days lived: ", $days;

		}

	}

}

sub montsSeries {
	my $rangeDays = 0;
	$endmonth--;
	while ( $endmonth > $startmonth ) {
		$rangeDays = $rangeDays + &number_of_days_in_month($endmonth);
		$endmonth--;
	}
	return $rangeDays;
}

sub number_of_days_in_month {
	my $month = shift;
	if (   ( $month == 4 )
		|| ( $month == 6 )
		|| ( $month == 9 )
		|| ( $month == 11 ) )
	{
		$month = 30;
	}
	elsif ( $month == 2 ) {
		$month = 28;
	}
	else {
		$month = 31;

	}

	return $month;
}

sub numbers_of_days_between_startend_daymonth {

	( $startmonth, $startday, $endmonth, $endday ) = @_;

	if (   ( $startmonth > $endmonth )
		|| ( $startmonth == $endmonth ) && ( $startday > $endday ) )
	{
		print "Inconrect Details";
		exit 0;

	}
	elsif ( $startmonth == $endmonth && $startday <= $endday ) {

		$days = $endday - $startday;

	}
	else {

		$days =
		  ( ( &number_of_days_in_month($startmonth) - ( $startday - 1 ) ) ) +
		  $endday + &montsSeries;
	}
	return $days;
}

sub isLeapYear {
	my $leapY = 0;

	my $year_birth   = shift;
	my $year_current = shift;

	while ( $year_birth < $year_current ) {

		if ( ( ( $year_birth % 4 ) == 0 ) && ( ( $year_birth % 100 ) != 0 )  || ( ( $year_birth % 400 ) == 0 ) ) {
			$leapY = $leapY + 1;
		}
		$year_birth++;
	}
	return $leapY;
}

sub isinteger {
	my $n = shift;    #get argument
	print "$n\n";
	if ( $n =~
		/^-?\d+$/ )    #if $n is an integer   ^beg $end  d+ more than one digits
	{
		return 1;
	}
	else {
		return 0;

	}
}

