SET SERVEROUTPUT ON;

DECLARE
  childrecord_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT
  (childrecord_exists, -02292);
 
BEGIN
  dbms_output.put_line('Excluindo departamento 40...');
  DELETE FROM DEPARTMENTS
  WHERE DEPARTMENT_ID = 40;
  COMMIT;
  
EXCEPTION
  WHEN childrecord_exists THEN
    dbms_output.put_line('Não é possível excluir um departamento com empregados cadastrados.');

END;
/