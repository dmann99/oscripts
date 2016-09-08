#!/usr/bin/perl

# David Mann
# ba6.us
# Extract SQL from an Oracle SQL Trace File (10046)
#
# Usage:
# Data is read from STDIN
# trc2sql.pl < input.trc > output.sql
#
# Change log:
# 13-OCT-2011 : Release

$InSQL = 0;
while (<>) {
  $MyLine = $_;
  $LineNum = $LineNum + 1;

  # If END OF STMT found, stop printing
  if (($InSQL==1) && ($MyLine =~ /END OF STMT/ )) {
    print ";\n\n\n";
    $InSQL = 0;
  }

  # In matching pattern, continue printing
  if ($InSQL == 1) {
    print $MyLine;
  }

  # If PARSING IN CURSOR found, start printing
  if ($MyLine =~ /PARSING IN CURSOR/) {
    print "-- " . $MyLine;
    $InSQL = 1;
  }

}
