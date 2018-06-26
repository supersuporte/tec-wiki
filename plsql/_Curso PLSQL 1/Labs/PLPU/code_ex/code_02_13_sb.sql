UPDATE employees
  SET salary = dml_call_sql(2000)
WHERE employee_id = 170;
