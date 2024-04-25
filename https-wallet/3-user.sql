connect sys/oracle@pdb as sysdba
drop user testuser cascade;
create user testuser identified by Oracle1234;
grant dba to testuser;
exit

