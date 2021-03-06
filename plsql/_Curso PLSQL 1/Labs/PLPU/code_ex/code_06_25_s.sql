CREATE PROCEDURE example_one IS
  h    NUMBER;
  th1  NUMBER;
  th2  NUMBER;
  doc  sys.ku$_ddls;
BEGIN
  h := DBMS_METADATA.OPEN('SCHEMA_EXPORT');
  DBMS_METADATA.SET_FILTER (h,'SCHEMA','HR');
  th1 := DBMS_METADATA.ADD_TRANSFORM (h,
    'MODIFY', NULL, 'TABLE');
  DBMS_METADATA.SET_REMAP_PARAM(th1,
    'REMAP_TABLESPACE', 'SYSTEM', 'TBS1');
  th2 :=DBMS_METADATA.ADD_TRANSFORM(h,'DDL');
  DBMS_METADATA.SET_TRANSFORM_PARAM(th2, 'SQLTERMINATOR', TRUE);
  DBMS_METADATA.SET_TRANSFORM_PARAM(th2, 'REF_CONSTRAINTS', FALSE, 'TABLE');
  LOOP
    doc := DBMS_METADATA.FETCH_DDL(h);
    EXIT WHEN doc IS NULL;
  END LOOP;
  DBMS_METADATA.CLOSE(h);
END;
/
