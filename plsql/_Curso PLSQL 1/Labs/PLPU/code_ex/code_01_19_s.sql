CREATE OR REPLACE PROCEDURE process_employees
IS
   CURSOR emp_cursor IS
    SELECT employee_id
    FROM   employees;
BEGIN
   FOR emp_rec IN emp_cursor 
   LOOP
     raise_salary(emp_rec.employee_id, 10);
   END LOOP;    
   COMMIT;
END process_employees;
/
