VARIABLE emp_salary NUMBER
SET AUTOPRINT ON
BEGIN
   SELECT salary  INTO :emp_salary 
   FROM  employees WHERE employee_id = 178;  
END;

