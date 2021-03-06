CREATE OR REPLACE PROCEDURE set_video(
  dir_alias VARCHAR2, dept_id NUMBER) IS
  filename VARCHAR2(40);  
  file_ptr BFILE;
  length number;
  CURSOR emp_csr IS
    SELECT first_name FROM employees
    WHERE department_id = dept_id FOR UPDATE;
BEGIN
  FOR rec IN emp_csr LOOP
    filename := rec.first_name || '.gif';
    file_ptr := BFILENAME(dir_alias, filename);
    length := get_filesize(file_ptr);
    IF length >= 0 THEN
      UPDATE employees
        SET video = file_ptr
      WHERE CURRENT OF emp_csr;
      DBMS_OUTPUT.PUT_LINE('Set BFILE for: ' || filename || ' Size: ' || length);
    ELSE
      DBMS_OUTPUT.PUT_LINE('BFILE: ' || filename || ' does not exist.');
    END IF;
  END LOOP;
  COMMIT;
END set_video;
/
SET SERVEROUTPUT ON
EXECUTE set_video('MEDIA_FILES', 60)
