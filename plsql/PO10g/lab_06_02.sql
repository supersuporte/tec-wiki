SET SERVEROUTPUT ON;
DECLARE
  TYPE dept_table_type IS TABLE OF
       departments.department_name%TYPE
  INDEX BY binary_integer;
 
  my_dept_table dept_table_type;
  loop_count NUMBER := 10;
  deptno NUMBER := 0;  

BEGIN
  FOR I IN 1..10 LOOP
    SELECT department_name
    INTO   my_dept_table(I)
    FROM   departments
    WHERE  department_id = I*10;  
  END LOOP;
  
  FOR I IN 1..10 LOOP
    dbms_output.put_line(' - ' || my_dept_table(I));    
  END LOOP;
END;
/