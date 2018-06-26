CREATE OR REPLACE FUNCTION query_call_sql(a NUMBER) RETURN NUMBER IS
   s NUMBER;
BEGIN
   SELECT salary INTO s FROM employees
   WHERE employee_id = 170;
   RETURN (s + a);
END;
/
