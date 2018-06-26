CREATE OR REPLACE PROCEDURE update_salary(emp_id NUMBER) IS
  name    employees.last_name%TYPE;
  new_sal employees.salary%TYPE;
BEGIN
  UPDATE employees 
    SET salary = salary * 1.1
  WHERE employee_id = emp_id
  RETURNING last_name, salary INTO name, new_sal;
END update_salary;
/
