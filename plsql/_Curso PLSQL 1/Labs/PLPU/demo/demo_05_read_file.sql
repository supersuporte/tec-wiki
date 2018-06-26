CREATE OR REPLACE PROCEDURE read_file(dir VARCHAR2, filename VARCHAR2) IS
  file UTL_FILE.FILE_TYPE;
  buffer VARCHAR2(200);
  lines  PLS_INTEGER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE(' Start ');
  IF NOT UTL_FILE.IS_OPEN(file) THEN
    DBMS_OUTPUT.PUT_LINE(' Open ');
    file := UTL_FILE.FOPEN (dir, filename, 'R');
    DBMS_OUTPUT.PUT_LINE(' Opened ');
    BEGIN
      LOOP
        UTL_FILE.GET_LINE(file, buffer);
        lines := lines + 1;
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(lines, '099')||' '||buffer);
      END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE(' ** End of File **');
    END;
    DBMS_OUTPUT.PUT_LINE(lines||' lines read from file');
    UTL_FILE.FCLOSE(file);
  END IF;
END read_file;
/
SHOW ERRORS
set serveroutput on
execute read_file('UTL_FILE', 'instructor.txt')
