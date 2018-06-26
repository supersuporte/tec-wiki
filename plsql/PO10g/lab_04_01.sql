DECLARE
  max_depto NUMBER;
BEGIN
  SELECT MAX(department_id)
  INTO   max_depto
  FROM   departments;
  COMMIT;

  dbms_output.put_line('Maior departamento é: ' || max_depto);
END;
/
