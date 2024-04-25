connect testuser/Oracle1234@pdb
col HOST for a30
col PRIVILEGE for a15
SELECT host, lower_port, upper_port, privilege, status FROM user_network_acl_privileges;
