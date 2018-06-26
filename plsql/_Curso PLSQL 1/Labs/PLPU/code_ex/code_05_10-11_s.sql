REM
REM Note: Using the PUT_LINE is more natural for PL/SQL developers.
REM However, the orginal examples of using PUTF are shown in comments.
REM
CREATE OR REPLACE PROCEDURE sal_status(dir IN VARCHAR2, filename IN VARCHAR2) IS
  file UTL_FILE.FILE_TYPE;
  CURSOR empc IS
    SELECT last_name, salary, department_id
    FROM employees ORDER BY department_id;
 newdeptno employees.department_id%TYPE;
 olddeptno employees.department_id%TYPE := 0;
BEGIN
  file:= UTL_FILE.FOPEN (dir, filename, 'w');
  UTL_FILE.PUT_LINE(file, 'REPORT: GENERATED ON ' ||SYSDATE);
  UTL_FILE.NEW_LINE (file);
  FOR emp_rec IN empc LOOP
    IF emp_rec.department_id <> olddeptno THEN
      /*
       * UTL_FILE.PUTF (file, 'DEPARTMENT: %s\n', emp_rec.department_id);
       */
      UTL_FILE.PUT_LINE (file, 'DEPARTMENT: ' || emp_rec.department_id);
 UTL_FILE.NEW_LINE (file);
    END IF;
    /*
     * UTL_FILE.PUTF (file,'  EMPLOYEE: %s earns: %s\n',
     *  emp_rec.last_name, emp_rec.salary);
     */
     UTL_FILE.PUTF (file,'  EMPLOYEE: ' || emp_rec.last_name || 
                         ' earns: ' || emp_rec.salary);
    olddeptno := emp_rec.department_id;
 UTL_FILE.NEW_LINE (file);
  END LOOP;
  UTL_FILE.PUT_LINE(file,'*** END OF REPORT ***');
  UTL_FILE.FCLOSE (file);
EXCEPTION
 WHEN UTL_FILE.INVALID_FILEHANDLE THEN
   RAISE_APPLICATION_ERROR(-20001,'Invalid File.');
 WHEN UTL_FILE.WRITE_ERROR THEN
   RAISE_APPLICATION_ERROR (-20002, 'Unable to write to file');
END sal_status;
/
