CREATE OR REPLACE VIEW emp_vw
AS SELECT employee_id, last_name, first_name, email, 
          department_id, hire_date, job_id, salary
   FROM employees
/
CREATE OR REPLACE PROCEDURE add_emp
(p_empid  IN emp_vw.employee_id%TYPE,
 p_lname  IN emp_vw.last_name%TYPE,
 p_fname  IN emp_vw.first_name%TYPE,
 p_email  IN emp_vw.email%TYPE,
 p_deptid IN emp_vw.department_id%TYPE,
 p_jobid  IN emp_vw.job_id%TYPE,
 p_salary IN emp_vw.salary%TYPE)

IS
BEGIN
  INSERT INTO emp_vw 
    (employee_id, last_name, first_name, email, 
     department_id, hire_date, job_id, salary)
  VALUES (p_empid, p_lname, p_fname, p_email, 
          p_deptid, sysdate, p_jobid, p_salary);
END add_emp;
/
CREATE OR REPLACE PROCEDURE query_emp
	(p_id      IN  employees.employee_id%TYPE,
	 p_lname   OUT employees.last_name%TYPE,
         p_fname   OUT employees.first_name%TYPE,
         p_email   OUT employees.email%TYPE,
	 p_salary  OUT employees.salary%TYPE,
	 p_comm    OUT employees.commission_pct%TYPE)
IS
BEGIN
	SELECT  last_name, first_name, email, salary, commission_pct 
	INTO    p_lname, p_fname, p_email, p_salary, p_comm
	FROM    employees
	WHERE   employee_id=p_id;
END query_emp;
/
