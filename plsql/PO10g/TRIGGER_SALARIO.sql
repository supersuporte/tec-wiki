create or replace
TRIGGER salario
  BEFORE INSERT OR UPDATE ON employees
  FOR EACH ROW
BEGIN
  VALIDA_SALARIO(:NEW.JOB_ID,:NEW.SALARY);
END;