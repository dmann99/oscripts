#!/u01/app/oracle/product/11.1.0.7/perl -w

use strict; 
use DBI; 

$SIG{INT} = \&cleanup;

# WatchLongops.pl 
# This program runs continuously to show current Long Operations on 
# an Oracle Instance.

# David Mann
# http://ba6.us
# dmann99@gmail.com

die "\nWatchInstanceLongops.pl\n\n" .
"This procedure watches long operations on an instance.\n\n" .
"syntax: perl $0 [SCHEMA_NAME]/[SCHEMA_PASSWORD]@[TNSNAME]\n"
if @ARGV < 0;

# Get command line arguments
my ( $connect_string ) = @ARGV;

# Connect to DB
print "Connecting to DB...\n";
my $dbh = getDBConnection( $connect_string );
### SQL Query that drives this procedure ###

my $sql = qq{ select ROUND(sofar/totalwork*100,2) as pct,
elapsed_seconds,
time_remaining,
v\$session_longops.message
from v\$session_longops
where sofar<>totalwork
order by target, sid
};

### Main Program : Begin ###

my ($percent, $secselap, $secsleft, $message);
my ($count);

my $sth = $dbh->prepare($sql);
while (1) {
  writeHeader($connect_string);

  # Prepare and execute SELECT
  $sth->execute();

  # Declare and Bind Columns
  $sth->bind_columns(undef, \$percent, \$secselap, \$secsleft, \$message);

  # Fetch rows from DB
  while( $sth->fetch() ) {
    writeOutputBlock($percent, $message, $secselap, $secsleft);
  }

  sleep(5);

}

print "\ndone\n";

# Close cursor
$sth->finish(); 
$dbh->disconnect() or warn "DB disconnection failed: $DBI::errstrn";
close(OUT);

### Main Program : End ###



# Function:   getDBConnection
# Parameters: $connectstring - connection string in format user/password@tnsname

sub getDBConnection {

  my ($connectstring) = @_;

  my $slashpos = index($connectstring,'/');
  my $atpos = index($connectstring,'@');
  die "missing /" if ($slashpos == -1);
  die "missing @" if ($atpos == -1);

  my $username = substr($connectstring, 0, $slashpos);
  my $password = substr($connectstring, $slashpos+1, $atpos - $slashpos - 1);
  my $tnsname  = substr($connectstring, $atpos + 1);
  return DBI->connect( "dbi:Oracle:".$tnsname,
                       $username,
                       $password,
                       {
                         RaiseError => 1,
                         AutoCommit => 0
                       }
                     ) || die "Database connection not made: $DBI::errstr";

};



# Function:   writeHeader
# Parameters: $connString - connection string in format user/password@tnsname

sub writeHeader {
  my ($connectstring) = @_;

  my $atpos = index($connectstring,'@');
  die "missing @" if ($atpos == -1);

  system "cls";
  system "clear";
  print "Monitoring Instance: " . substr($connectstring, $atpos + 1) . "\n\n";

};



# Function:   writeOutputBlock
# Parameters: $percent - percent done (0 - 100)
#             $message - Text message from v$session_longops
#             $secselap - Seconds elapsed from v$session_longops
#             $secsleft - Estimated seconds left from v$session_longops

sub writeOutputBlock {

my ($percent, $message, $secselap, $secsleft) = @_;

print substr($message,0,79) . "\n";
print "Percent : $percent    ";
print "Minutes elapsed : " . int($secselap/60) . ":" . sprintf("%02s", $secselap % 60) . "      ";
print "Est. Minutes left : " . int($secsleft/60) . ":" . sprintf("%02s", $secsleft % 60) . "\n";
&writeProgressBar($percent,80);

};



# Function:   writeProgressBar
# Parameters: $perc - percent done (0 - 100)
#             $width - Total width of the Progress Bar

sub writeProgressBar {

  my ($perc, $width) = @_;

  my $spaces = int($perc / 100 * ($width-2));

  print "|";
  for ($count = 1; $count <= ($width-2); $count++) {
    if ($count < $spaces)  {
      print "X";
    } else {
      print "=";
    }
  };
  print "|\n";

};

sub cleanup {die "\nending\n";}
