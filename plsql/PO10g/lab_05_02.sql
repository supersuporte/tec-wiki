--DEFINE empno = 176;

DECLARE
  asterisk emp.stars%TYPE := NULL;
  sal 	   emp.salary%TYPE;
BEGIN
  SELECT SALARY
  INTO   sal
  FROM emp
  WHERE employee_id = &empno;
  
  sal := sal/1000;

  FOR I IN 1..sal LOOP
    asterisk := asterisk || '*';
  END LOOP;

  UPDATE emp SET stars = asterisk
  WHERE employee_id = &empno;
  COMMIT;

  dbms_output.put_line(asterisk);

END;
/