DROP TABLE copy_emp;
CREATE TABLE copy_emp AS (SELECT * FROM employees WHERE 1= 2);
CREATE TABLE emp_demo AS SELECT * FROM employees;
-- Insert one row into the copy_emp table and update its value. 
-- This helps in observing that the MERGE worked successfully.

INSERT INTO COPY_EMP (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100);
SELECT * FROM COPY_EMP;
UPDATE COPY_EMP
SET LAST_NAME='VALLI' WHERE employee_id = 100;
SELECT * FROM copy_emp WHERE employee_id = 100;
SELECT * FROM emp_demo WHERE employee_id = 100;

--  PL/SQL block that contains the MERGE statement

DECLARE
	empno employees.employee_id%TYPE := 100;
BEGIN
MERGE INTO copy_emp c
     USING emp_demo e
     ON (e.employee_id = c.empno)
   WHEN MATCHED THEN
     UPDATE SET
       c.first_name     = e.first_name,
       c.last_name      = e.last_name,
       c.email          = e.email,
       c.phone_number   = e.phone_number,
       c.hire_date      = e.hire_date,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.commission_pct = e.commission_pct,
       c.manager_id     = e.manager_id,
       c.department_id  = e.department_id
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id,  e.first_name, e.last_name,
          e.email, e.phone_number, e.hire_date, e.job_id,
          e.salary, e.commission_pct, e.manager_id, 
          e.department_id);
END;
/

--  Observe that the MERGE is successful
SELECT COUNT(*) FROM copy_emp;
SELECT * FROM copy_emp WHERE employee_id = 100;
SELECT * FROM emp_demo WHERE employee_id = 100;