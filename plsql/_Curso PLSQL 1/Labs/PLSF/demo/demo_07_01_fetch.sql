SET SERVEROUTPUT ON
DECLARE
  CURSOR emp_cursor IS 
   SELECT employee_id, last_name FROM employees
   WHERE department_id =30;
  empno employees.employee_id%TYPE;
  lname employees.last_name%TYPE;
BEGIN
  OPEN emp_cursor;
  FETCH emp_cursor INTO empno, lname;
    
  WHILE  emp_cursor%FOUND LOOP
    DBMS_OUTPUT.PUT_LINE( empno ||'  '||lname);
    FETCH emp_cursor INTO empno, lname;
  END LOOP;
END;


