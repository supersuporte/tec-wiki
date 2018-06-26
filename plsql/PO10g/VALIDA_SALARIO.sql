CREATE OR REPLACE PROCEDURE VALIDA_SALARIO(cargo VARCHAR2,salario VARCHAR2) AS
  v_min_salary JOBS.MIN_SALARY%TYPE;
  v_max_salary JOBS.MAX_SALARY%TYPE;
  
BEGIN
  SELECT MIN_SALARY,MAX_SALARY
  INTO v_min_salary,v_max_salary
  FROM JOBS
  WHERE JOB_ID = cargo;

  IF salario < v_min_salary THEN
    RAISE_APPLICATION_ERROR(-20100,'\nErro de salário. Cargo com salário ABAIXO do intervalo permitido.');
  ELSIF salario > v_max_salary THEN
    RAISE_APPLICATION_ERROR(-20200,'\nErro de salário. Cargo com salário ACIMA do intervalo permitido.');
  END IF;

END;
/