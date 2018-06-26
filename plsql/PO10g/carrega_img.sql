CREATE OR REPLACE PROCEDURE carrega_img(dir_alias VARCHAR2) IS
  filename VARCHAR2(40);
  file_ptr BFILE;
  
  CURSOR c_csr IS
    SELECT country_id FROM countries
    WHERE region_id = 1 FOR UPDATE;
    
BEGIN
  FOR rec IN c_csr LOOP
    filename := rec.country_id || '.gif';
    file_ptr := BFILENAME(dir_alias, filename);
    UPDATE countries SET img = file_ptr
      WHERE CURRENT OF c_csr;
    DBMS_OUTPUT.PUT_LINE('Arquivo: ' || filename || ', ' || DBMS_LOB.GETLENGTH(file_ptr));
  END LOOP;
  COMMIT;
END;
/
