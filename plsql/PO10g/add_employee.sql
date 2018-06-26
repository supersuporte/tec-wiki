CREATE OR REPLACE PROCEDURE add_employee(first_name EMPLOYEES.FIRST_NAME%TYPE,
                                         last_name  EMPLOYEES.LAST_NAME%TYPE,
                                         email      EMPLOYEES.EMAIL%TYPE,
                                         job        EMPLOYEES.JOB_ID%TYPE         := 'SA_REP',
                                         mgr        EMPLOYEES.MANAGER_ID%TYPE     := 145,
                                         sal        EMPLOYEES.SALARY%TYPE         := 1000,
                                         comm       EMPLOYEES.COMMISSION_PCT%TYPE := 0,
                                         deptid     EMPLOYEES.DEPARTMENT_ID%TYPE  := 30) AS
BEGIN
  IF valid_deptid(deptid) THEN
    INSERT INTO EMPLOYEES VALUES (EMPLOYEES_SEQ.nextval,
            first_name,
            last_name,
            email,
            '555',
            TRUNC(SYSDATE),
            job,
            sal,
            comm,
            mgr,
            deptid);
    COMMIT;
    dbms_output.put_line('Funcionário incluído com sucesso.');
  ELSE
    dbms_output.put_line('ERRO: departamento não existe.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Não é possível gravar. Erro fatal. Consulte o Administrador do Sistema.');

END;
/