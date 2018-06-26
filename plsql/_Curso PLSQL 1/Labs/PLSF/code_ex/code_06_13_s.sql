SET SERVEROUTPUT ON
SET VERIFY OFF

DROP TABLE retired_emps;


CREATE TABLE retired_emps
   (EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    LEAVEDATE  DATE,
    SAL        NUMBER(7,2),
    COMM       NUMBER(7,2),
    DEPTNO     NUMBER(2))
/

DEFINE employee_number = 124
DECLARE
   emp_rec  retired_emps%ROWTYPE;
BEGIN
 SELECT employee_id, last_name, job_id, manager_id, hire_date, hire_date,
  salary, commission_pct, department_id 
 INTO emp_rec FROM employees
 WHERE  employee_id = &employee_number;
 INSERT INTO retired_emps  VALUES emp_rec;
END;

/

SELECT * FROM retired_emps;




