

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT deptno PROMPT 'Please enter the department number: '
ACCEPT name   PROMPT 'Please enter the department name: '
DECLARE
  invalid_department EXCEPTION;
  name VARCHAR2(20):='&name';
  deptno NUMBER :=&deptno;
BEGIN
  UPDATE	departments
  SET  department_name = name
  WHERE	department_id = deptno;
  IF SQL%NOTFOUND THEN
    RAISE invalid_department;
  END IF;
  COMMIT;
EXCEPTION
  WHEN invalid_department  THEN
    DBMS_OUTPUT.PUT_LINE('No such department id.');
END;







