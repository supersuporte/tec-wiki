SET SERVEROUTPUT ON;
DECLARE
  CURSOR dept_cursor IS
  SELECT department_id,department_name
  FROM   departments
  WHERE  department_id < 100
  ORDER BY department_id;
 
  CURSOR emp_cursor(deptno NUMBER) IS
  SELECT last_name,job_id,hire_date,salary
  FROM   EMPLOYEES
  WHERE  employee_id < 120
  AND    department_id = deptno;

BEGIN
  FOR dept_record IN dept_cursor LOOP
    dbms_output.put_line(dept_record.department_id || '. ' || dept_record.department_name);
    FOR emp_record IN emp_cursor(dept_record.department_id) LOOP
      dbms_output.put_line('  >' || emp_record.last_name|| ': ' || emp_record.job_id);
    END LOOP;
  END LOOP;
  
END;
/