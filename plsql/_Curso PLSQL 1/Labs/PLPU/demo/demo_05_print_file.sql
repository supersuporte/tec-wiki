CREATE OR REPLACE PROCEDURE print_file(dir VARCHAR2, filename VARCHAR2) IS
  file   UTL_FILE.FILE_TYPE;
  buffer VARCHAR2(300);
BEGIN
  file := UTL_FILE.FOPEN(dir, filename,'r');
  LOOP
    UTL_FILE.GET_LINE(file, buffer);
    DBMS_OUTPUT.PUT_LINE(nvl(buffer, chr(10)));
  END LOOP;
  UTL_FILE.FCLOSE(file);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    UTL_FILE.FCLOSE(file);
END;
/
SET SERVEROUTPUT ON
EXECUTE print_file('UTL_FILE', 'instructor.txt')


