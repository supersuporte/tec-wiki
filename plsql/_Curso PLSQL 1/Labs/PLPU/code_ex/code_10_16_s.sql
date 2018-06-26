INSERT INTO employees (employee_id, last_name, job_id, salary, email, hire_date)
VALUES (999, 'Temp emp', 'SA_REP', 6000, 'TEMPEMP', TRUNC(SYSDATE));

UPDATE employees
 SET salary = 7000, last_name = 'Smith'
 WHERE employee_id = 999;

SELECT *
FROM audit_emp;

