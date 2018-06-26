CREATE OR REPLACE
TRIGGER salario_minimo
  AFTER UPDATE ON JOBS
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
  UPDATE employees
  SET    salary = :NEW.min_salary
  WHERE  JOB_ID = :NEW.job_id
  AND    salary < :NEW.min_salary;
  COMMIT;
END;
/