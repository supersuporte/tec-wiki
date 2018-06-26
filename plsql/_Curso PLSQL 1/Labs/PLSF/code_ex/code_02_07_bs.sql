SET SERVEROUTPUT ON
DECLARE
  Myname VARCHAR(20):= 'John';
BEGIN
  Myname := 'Steven';
  DBMS_OUTPUT.PUT_LINE('My name is: '||Myname);
END; 
