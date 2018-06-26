VARIABLE emp_salary NUMBER
SET AUTOPRINT ON
DECLARE
  empno NUMBER(6):=&empno;
BEGIN
   SELECT salary  INTO :emp_salary 
   FROM  employees WHERE employee_id = empno;  
END;

