create or replace
PACKAGE EMP_PKG IS
  TYPE emp_type IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY PLS_INTEGER;
  
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

  PROCEDURE get_employess(dept_id EMPLOYEES.DEPARTMENT_ID%TYPE);
  
  PROCEDURE show_employees;
END;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
create or replace
PACKAGE BODY EMP_PKG IS
  emp_table emp_type;
-----------------------------------------------  
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
-----------------------------------------------
PROCEDURE get_employess(dept_id EMPLOYEES.DEPARTMENT_ID%TYPE) AS

BEGIN
  SELECT * BULK COLLECT INTO emp_table
  FROM EMPLOYEES
  WHERE department_id = dept_id;

END get_employess;
-----------------------------------------------
PROCEDURE show_employees AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Lista de Empregados');
  DBMS_OUTPUT.PUT_LINE('=================================================');  
  IF emp_table.COUNT <> 0 THEN
    FOR I IN 1..emp_table.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE(emp_table(I).first_name || ' ' || emp_table(I).last_name);
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nenhum empregado neste departamento');  
  END IF;
END show_employees;

END EMP_PKG;