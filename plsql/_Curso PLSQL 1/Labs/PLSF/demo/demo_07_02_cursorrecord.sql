DROP TABLE temp_list;
CREATE TABLE temp_list (empid NUMBER(10) NOT NULL, empname VARCHAR2(25) NOT NULL);
DECLARE
      CURSOR emp_cursor IS SELECT employee_id, last_name
        FROM   employees;
      emp_record emp_cursor%ROWTYPE;
BEGIN
      OPEN emp_cursor;
      LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        INSERT INTO temp_list (empid, empname)
        VALUES (emp_record.employee_id, emp_record.last_name);
      END LOOP;
      CLOSE emp_cursor;
END;


