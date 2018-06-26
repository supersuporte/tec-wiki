SET SERVEROUTPUT ON;
DEFINE p_num;
DECLARE
  num NUMBER := &pn_num;
  sal employees.salary%TYPE;
  
  CURSOR emp_cursor IS
    SELECT distinct salary
    FROM EMPLOYEES
    ORDER BY salary DESC;

BEGIN
  OPEN emp_cursor;

  LOOP  
    FETCH emp_cursor INTO sal;
    EXIT WHEN emp_cursor%NOTFOUND OR emp_cursor%ROWCOUNT > num;
    
    dbms_output.put_line(sal);
    INSERT INTO TOP_SALARIES VALUES (sal);
    COMMIT;    
  END LOOP;

  CLOSE emp_cursor;
  
END;
/