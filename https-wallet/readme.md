# Steps
## Get cert info
- 1-getcerts-google.sh
- 1-getcerts-apex.sh
- 1-getcerts-atlassian.sh
## Parse cert info
- python 2-parsecerts.py
## Create Oracle user
- sqlplus /nolog @3-user.sql
## Create ACLs
- sqlplus /nolog @4-acls-google.sql      
- sqlplus /nolog @4-acls-dplinv.sql
- sqlplus /nolog @4-acls-atlassian.sql  
## Run a test
- sqlplus /nolog @5-query-google.sql
- sqlplus /nolog @5-query-dplinv.sql
- sqlplus /nolog @5-query-atlassian.sql
## Verification
- sqlplus /nolog @6-check.sql
