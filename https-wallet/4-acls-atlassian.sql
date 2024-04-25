connect sys/oracle@pdb as sysdba
BEGIN
    DBMS_NETWORK_ACL_ADMIN.DROP_ACL (
      acl => 'atlassian-permissions.xml');
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
     acl          => 'atlassian-permissions.xml',
     description  => 'Test',
     principal    => 'TESTUSER',
     is_grant     =>  TRUE,
     privilege    => 'connect' );

  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
     acl          => 'atlassian-permissions.xml',
     principal    => 'TESTUSER',
     is_grant     =>  TRUE,
     privilege    => 'resolve' );

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => 'sas-institute.atlassian.net',
                                    lower_port => 443, upper_port => null);

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => 'api.atlassian.net',
                                    lower_port => 443, upper_port => null);

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => '*.atlassian.net',
                                    lower_port => 443, upper_port => null);
  
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => '104.192.142.18',
                                    lower_port => 443, upper_port => null);
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => '104.192.142.19',
                                    lower_port => 443, upper_port => null);
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'atlassian-permissions.xml',
                                    host => '104.192.142.20',
                                    lower_port => 443, upper_port => null);




END;
/

connect testuser/Oracle1234@pdb
col HOST for a30
col PRIVILEGE for a15
SELECT host, lower_port, upper_port, privilege, status FROM user_network_acl_privileges;
