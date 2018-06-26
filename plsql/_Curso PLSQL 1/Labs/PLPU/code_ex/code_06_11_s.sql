CREATE PROCEDURE process_data IS
  TYPE ref_ctype IS REF CURSOR; -- weak ref cursor
  TYPE emp_ref_ctype IS REF CURSOR -- strong
     RETURN employees%ROWTYPE;
  dept_csrvar ref_ctype;
  emp_csrvar  emp_ref_ctype;
  emprec      employees%rowtype;
  deptrec     departments%rowtype;
BEGIN
  OPEN emp_csrvar FOR SELECT * FROM employees;
  LOOP
    FETCH emp_csrvar INTO emprec;
    EXIT when emp_csrvar%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(emprec.employee_id||' '||emprec.last_name);
  END LOOP;
  CLOSE emp_csrvar;

  OPEN dept_csrvar FOR SELECT * from departments;
  LOOP
    FETCH dept_csrvar INTO deptrec;
    EXIT when dept_csrvar%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(deptrec.department_id||' '||deptrec.department_name);
  END LOOP;
  CLOSE dept_csrvar;
END;
/
