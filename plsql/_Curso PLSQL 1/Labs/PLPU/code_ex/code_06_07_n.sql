CREATE PROCEDURE add_col(table_name VARCHAR2,
                         col_spec VARCHAR2) IS
  stmt VARCHAR2(100) := 'ALTER TABLE ' || table_name ||
                        ' ADD '||col_spec;
BEGIN
  EXECUTE IMMEDIATE stmt;
END;
/
EXECUTE add_col('employee_names', 'salary number(8,2)')
