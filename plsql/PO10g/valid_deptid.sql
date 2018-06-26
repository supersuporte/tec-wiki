CREATE OR REPLACE FUNCTION valid_deptid(dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURN BOOLEAN AS
  v_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
  SELECT DEPARTMENT_ID
  INTO   v_id
  FROM   DEPARTMENTS
  WHERE  DEPARTMENT_ID = dept_id;
  RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;

END;
/