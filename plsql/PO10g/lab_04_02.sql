--VARIABLE dept_id NUMBER;
DECLARE
  max_depto NUMBER;
  dept_name departments.department_name%TYPE := 'Educacao';
BEGIN
  SELECT MAX(department_id)
  INTO   max_depto
  FROM   departments;
  COMMIT;

  :dept_id := max_depto+10;

  INSERT INTO departments
	      (department_name,department_id,location_id)
  VALUES (dept_name,:dept_id,NULL); 
  dbms_output.put_line(SQL%ROWCOUNT || ' linhas inseridas');
  COMMIT;

END;
/
