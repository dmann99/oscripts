
connect testuser/Oracle1234@pdb
col HOST for a30
col PRIVILEGE for a15
SELECT host, lower_port, upper_port, privilege, status FROM user_network_acl_privileges;

ALTER SESSION SET EVENTS = '10937 TRACE NAME CONTEXT FOREVER, LEVEL 4';

exec utl_http.set_wallet('file:/home/oracle/cert-decode', 'WalletPassword123');
SELECT utl_http.request('https://www.google.com') from dual;
