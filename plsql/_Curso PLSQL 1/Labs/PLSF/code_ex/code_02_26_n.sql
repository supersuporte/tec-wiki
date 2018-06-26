VARIABLE result NUMBER
BEGIN
  SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :result
  FROM employees WHERE employee_id = 144;
END;
/
PRINT result
