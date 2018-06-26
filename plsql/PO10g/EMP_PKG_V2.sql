CREATE OR REPLACE PACKAGE EMP_PKG IS
  PROCEDURE add_employee(first_name EMPLOYEES.FIRST_NAME%TYPE,
                         last_name  EMPLOYEES.LAST_NAME%TYPE,
                         email      EMPLOYEES.EMAIL%TYPE,
                         job        EMPLOYEES.JOB_ID%TYPE         := 'SA_REP',
                         mgr        EMPLOYEES.MANAGER_ID%TYPE     := 145,
                         sal        EMPLOYEES.SALARY%TYPE         := 1000,
                         comm       EMPLOYEES.COMMISSION_PCT%TYPE := 0,
                         deptid     EMPLOYEES.DEPARTMENT_ID%TYPE  := 30);

  PROCEDURE add_employee(first_name EMPLOYEES.FIRST_NAME%TYPE,
                         last_name  EMPLOYEES.LAST_NAME%TYPE,
                         deptid     EMPLOYEES.DEPARTMENT_ID%TYPE  := 30);

END;
/
--------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY EMP_PKG IS
  FUNCTION valid_deptid(dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURN BOOLEAN AS
  v_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
  SELECT DEPARTMENT_ID
  INTO   v_id
  FROM   DEPARTMENTS
  WHERE  DEPARTMENT_ID = dept_id;
  RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END valid_deptid; 
-----------------------------------------------
PROCEDURE add_employee(first_name EMPLOYEES.FIRST_NAME%TYPE,
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

END add_employee;
-------------------------------------------
PROCEDURE add_employee(first_name EMPLOYEES.FIRST_NAME%TYPE,
                       last_name  EMPLOYEES.LAST_NAME%TYPE,
                       deptid     EMPLOYEES.DEPARTMENT_ID%TYPE  := 30) AS
  v_email EMPLOYEES.EMAIL%TYPE := UPPER(SUBSTR(first_name,1,1) || SUBSTR(last_name,1,7));
BEGIN
  add_employee(first_name,last_name,v_email,deptid=>deptid);

END add_employee;

END EMP_PKG;
