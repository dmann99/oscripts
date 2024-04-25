connect sys/oracle@pdb as sysdba
BEGIN
    DBMS_NETWORK_ACL_ADMIN.DROP_ACL (
      acl => 'google-permissions.xml');
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
     acl          => 'google-permissions.xml',
     description  => 'Test',
     principal    => 'TESTUSER',
     is_grant     =>  TRUE,
     privilege    => 'connect' );

  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
     acl          => 'google-permissions.xml',
     principal    => 'TESTUSER',
     is_grant     =>  TRUE,
     privilege    => 'resolve' );

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'google-permissions.xml',
                                    host => '*.google.com',
                                    lower_port => 443, upper_port => null);


END;
/


# www.google.com works


connect testuser/Oracle1234@pdb
col HOST for a30
col PRIVILEGE for a15
SELECT host, lower_port, upper_port, privilege, status FROM user_network_acl_privileges;
