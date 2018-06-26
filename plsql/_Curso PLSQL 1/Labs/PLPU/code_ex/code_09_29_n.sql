DECLARE
  rlob   CLOB;
  text   VARCHAR2(4001);
  amt    NUMBER := 4001;
  offset NUMBER := 1;
BEGIN
 SELECT resume INTO rlob FROM emp_hiredata
 WHERE employee_id = 170;
 DBMS_LOB.READ(rlob, amt, offset, text);
 DBMS_OUTPUT.PUT_LINE('text is: '|| text);
END;
/
