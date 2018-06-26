SET SERVEROUTPUT ON;

DECLARE
  sal_increase employees.salary%TYPE := 800;
BEGIN
  UPDATE EMPLOYEES
  SET    salary = salary + sal_increase
  WHERE  employee_id = 10;

  IF SQL%NOTFOUND THEN
    dbms_output.put_line('Nenhuma linha atualizada');
  ELSE
    dbms_output.put_line('Linha atualizada com sucesso');
  END IF;

  COMMIT;

END;
/