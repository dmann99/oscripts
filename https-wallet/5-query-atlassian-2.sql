

connect testuser/Oracle1234@pdb
col HOST for a30
col PRIVILEGE for a15
SELECT host, lower_port, upper_port, privilege, status FROM user_network_acl_privileges;

--ALTER SESSION SET EVENTS = '10937 TRACE NAME CONTEXT FOREVER, LEVEL 4';

SELECT utl_http.request('https://sas-institute.atlassian.net') from dual;
SELECT utl_http.request('https://sas-institute.atlassian.net/jira/your-work') from dual;


SET SERVEROUTPUT ON
DECLARE
   req   UTL_HTTP.req;
   resp  UTL_HTTP.resp;
   url   VARCHAR2(4000) := 'https://sas-institute.atlassian.net/jira/your-work';
BEGIN
 
   req := UTL_HTTP.begin_request(url);
   resp := UTL_HTTP.get_response(req);

   -- Check if the response status code indicates a redirection
   utl_http.set_wallet('file:/home/oracle/cert-decode', 'WalletPassword123');
   IF resp.status_code IN (301, 302, 303, 307, 308) THEN
      -- Check if the "Location" header is present
      IF UTL_HTTP.get_header_value(resp, 'Location') IS NOT NULL THEN
         -- Handle redirection
         DBMS_OUTPUT.put_line('Redirected to: ' || UTL_HTTP.get_header_value(resp, 'Location'));
      END IF;
   ELSE
      -- Process the response normally
      -- ...
   END IF;

   UTL_HTTP.end_response(resp);
EXCEPTION
   WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response(resp);
END;
/

