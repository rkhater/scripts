#!/usr/bin/perl -w
use integer;

# Author: Ramy Khater <ramy.m.khater@gmail.com>
# Date: April 9th, 2003
# Purpose: To display a calendar for the current or any given month.
# Usage: It takes two parameters: The first one is the month (1..12) and the second one is the year (four digits).
#        If no parameter is given, the calendar for the current month is displayed.
#        This script is only for Gregorian calendars <https://goo.gl/s8CQsG>.

# Copyright (c) 2003 Ramy Khater <ramy.m.khater@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software, To deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#

my %months = (
  "jan" => {name => " January", length => 31, order => 1}, "feb" => {name => " February", length => => 28, order => 2},
  "mar" => {name => "  March", length => 31, order => 3}, "apr" => {name => "  April", length => 30, order => 4},
  "may" => {name => "   May", length => 31, order => 5}, "jun" => {name => "  June", length => 30, order => 6},
  "jul" => {name => "  July", length => 31, order => 7}, "aug" => {name => "  August", length => 31, order => 8},
  "sep" => {name => "September", length => 30, order => 9}, "oct" => {name => " October", length => 31, order => 10},
  "nov" => {name => " November", length => 30, order => 11}, "dec" => {name => " December", length => 31, order => 12},
);
@months_abbr = qw('' jan feb mar apr may jun jul aug sep oct nov dec);

# Halt if too many paramaters passed
die "Usage: calendar.pl [month] [year]\n" if $#ARGV > 1;
$mon = (defined $ARGV[0]) ? $ARGV[0] : $months{lc(substr(scalar localtime, 4, 3))}->{order};

if ($mon =~ /^ *\d{1,2} *$/) {
  die "Month must be between 1 and 12!\n" unless ($mon>=1 && $mon<=12);
} else {
  $mon = $months{lc(substr($mon,0,3))}->{order};
  die "Wrong month name: $ARGV[0]!\n" unless defined($mon);
}
$month_name = $months{$months_abbr[$mon]}->{name};

$year = (defined $ARGV[1]) ? $ARGV[1] : lc(substr(scalar localtime, 20, 4));
die "Error: Year must be four digits e.g: 1984 $year!\n" unless $year =~ /^ *\d{4} *$/;
$year = int($year);
die "Error: Year must be greater than 0!\n" unless $year>0;


print "\n\t$month_name $year\n\nSun  Mon  Tue  Wed  Thu  Fri  Sat\n";
$months{feb}->{length} = 29 if ($year%400==0) || (($year%4==0) && ($year%100!=0));
--$year;
$st = 1 + $year*365 + $year/4 - $year/100 + $year/400;

for ($i=1; $i<$mon; ++$i) {
  $st += int($months{$months_abbr[$i]}->{length});
}

$st %= 7;
for ($i=0; $i<$st; ++$i) {
  print "     ";
}
for ($i=1; $i<=int($months{$months_abbr[$mon]}->{length}); ++$i) {
  printf "%3d  ", $i;
  print "\n" if ($st+$i)%7==0;
}
print "\n\n";
