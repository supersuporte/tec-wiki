SET SERVEROUTPUT ON
DECLARE
  empno	employees.employee_id%TYPE;
  ename	employees.last_name%TYPE;
  CURSOR emp_cursor IS SELECT employee_id,  last_name FROM 
   employees;
BEGIN
  OPEN emp_cursor;
  LOOP
   FETCH emp_cursor INTO empno, ename;
   EXIT WHEN emp_cursor%ROWCOUNT > 10 OR  
                     emp_cursor%NOTFOUND;        
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(empno) 
                       ||' '|| ename);
  END LOOP;
  CLOSE emp_cursor;
END ;

