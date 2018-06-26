CREATE OR REPLACE PROCEDURE get_departments(loc NUMBER,
   nrows NUMBER) IS
  CURSOR dept_csr IS
    SELECT * FROM departments
     WHERE location_id = loc;
  TYPE dept_tabtype IS TABLE OF dept_csr%ROWTYPE;
  depts dept_tabtype;
BEGIN
  OPEN dept_csr;
  FETCH dept_csr BULK COLLECT INTO depts LIMIT nrows;
  CLOSE dept_csr;
  DBMS_OUTPUT.PUT_LINE(depts.COUNT||' rows read');
END;
/
EXECUTE get_departments(1700, 5)
