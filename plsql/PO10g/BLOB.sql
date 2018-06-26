DROP TABLE blob_table;

CREATE TABLE blob_table (
  id    NUMBER PRIMARY KEY,
  image BLOB);

DECLARE
  v_id       NUMBER := 1;
  v_filename VARCHAR2(100) := 'BE.GIF';
  v_bfile    BFILE;
  v_blob     BLOB;

BEGIN
  INSERT INTO blob_table (id,image)
  VALUES (v_id, EMPTY_BLOB())
  RETURN image INTO v_blob;
  
  v_bfile := BFILENAME('COUNTRY_PIC',v_filename);
  DBMS_LOB.FILEOPEN(v_bfile, dbms_lob.file_readonly);
  DBMS_LOB.LOADFROMFILE(v_blob, v_bfile,
                       DBMS_LOB.GETLENGTH(v_bfile));
  DBMS_LOB.FILECLOSE(v_bfile);
  COMMIT;
END;
/