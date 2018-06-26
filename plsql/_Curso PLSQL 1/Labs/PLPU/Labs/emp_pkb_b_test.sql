CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  TYPE boolean_tabtype IS TABLE OF BOOLEAN
    INDEX BY BINARY_INTEGER;
  valid_departments boolean_tabtype;
  
  FUNCTION valid_deptid(deptid IN departments.department_id%TYPE) 
   RETURN BOOLEAN;

  PROCEDURE add_employee( 
    first_name employees.first_name%TYPE, 
    last_name employees.last_name%TYPE, 
    email employees.email%TYPE, 
    job employees.job_id%TYPE DEFAULT 'SA_REP', 
    mgr employees.manager_id%TYPE DEFAULT 145, 
    sal employees.salary%TYPE DEFAULT 1000, 
    comm employees.commission_pct%TYPE DEFAULT 0, 
    deptid employees.department_id%TYPE DEFAULT 30) IS 
  BEGIN 
    IF valid_deptid(deptid) THEN 
      INSERT INTO employees(employee_id, first_name, last_name, email, 
        job_id, manager_id, hire_date, salary, commission_pct, department_id) 
      VALUES (employees_seq.NEXTVAL, first_name, last_name, email, 
        job, mgr, TRUNC(SYSDATE), sal, comm, deptid); 
    ELSE 
      RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.'); 
    END IF; 
  END add_employee; 

  PROCEDURE add_employee( 
    first_name employees.first_name%TYPE, 
    last_name employees.last_name%TYPE, 
    deptid employees.department_id%TYPE) IS
    email employees.email%type;
  BEGIN
    email := UPPER(SUBSTR(first_name, 1, 1)||SUBSTR(last_name, 1, 7));
    add_employee(first_name, last_name, email, deptid => deptid);
  END;

  PROCEDURE get_employee(
    empid IN employees.employee_id%TYPE, 
    sal OUT employees.salary%TYPE, 
    job OUT employees.job_id%TYPE) IS 
  BEGIN 
    SELECT salary, job_id 
    INTO sal, job 
    FROM employees 
    WHERE employee_id = empid; 
  END get_employee; 

  FUNCTION get_employee(emp_id employees.employee_id%type)
    return employees%rowtype IS
    emprec employees%rowtype;
  BEGIN
    SELECT * INTO emprec
    FROM employees
    WHERE employee_id = emp_id;
    RETURN emprec;
  END;

  FUNCTION get_employee(family_name employees.last_name%type)
    return employees%rowtype IS
    emprec employees%rowtype;
  BEGIN
    SELECT * INTO emprec
    FROM employees
    WHERE last_name = family_name;
    RETURN emprec;
  END;

  PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id FROM departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;

  PROCEDURE print_employee(emprec employees%rowtype) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(emprec.department_id ||' '|| 
                         emprec.employee_id||' '||
                         emprec.first_name||' '||
                         emprec.last_name||' '||
                         emprec.job_id||' '||
                         emprec.salary);
  END;

  FUNCTION valid_deptid(deptid IN departments.department_id%TYPE) 
   RETURN BOOLEAN IS 
    dummy PLS_INTEGER; 
  BEGIN 
    RETURN valid_departments.exists(deptid); 
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
    RETURN FALSE; 
  END valid_deptid; 

BEGIN
  init_departments;
END emp_pkg;
/
SHOW ERRORS
