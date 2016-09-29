#!/usr/bin/ksh
export ORACLE_HOME=/u01/app/oracle/product/11.1.0.6
export PERL5LIB=$ORACLE_HOME/perl/lib/5.6.1/sun4-solaris:$ORACLE_HOME/perl/lib/5.6.1:$ORACLE_HOME/perl/lib/site_perl/5.6.1/sun4-solaris:$ORACLE_HOME/perl/lib/site_perl/5.6.1
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/lib32
export TNS_ADMIN=/u01/app/oracle/product/11.1.0.6/network/admin

$ORACLE_HOME/perl/bin/perl longops.pl username/password@tnsname
