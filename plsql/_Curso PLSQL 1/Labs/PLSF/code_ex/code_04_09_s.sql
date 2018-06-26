DECLARE
  emp_hiredate   employees.hire_date%TYPE;
  emp_salary     employees.salary%TYPE;  
BEGIN
  SELECT   hire_date, salary
  INTO        emp_hiredate, emp_salary
  FROM      employees
  WHERE   employee_id = 100;  
END;

