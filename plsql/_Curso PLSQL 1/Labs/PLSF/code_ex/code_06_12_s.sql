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
  emp_rec   employees%ROWTYPE;
BEGIN
 SELECT * INTO emp_rec FROM employees
 WHERE  employee_id = &employee_number;
 INSERT INTO retired_emps(empno, ename, job, mgr,  hiredate,  
                                         leavedate, sal, comm, deptno)  
 VALUES (emp_rec.employee_id, emp_rec.last_name,  
 emp_rec.job_id,emp_rec.manager_id,  emp_rec.hire_date, SYSDATE, 
 emp_rec.salary,  emp_rec.commission_pct, emp_rec.department_id);
END;

/

SELECT * FROM retired_emps;


