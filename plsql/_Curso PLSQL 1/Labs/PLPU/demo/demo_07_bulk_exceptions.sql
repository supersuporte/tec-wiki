DECLARE
  TYPE NumList IS TABLE OF NUMBER;
  num_tab NumList := NumList(10,0,11,12,30,0,20,199,2,0,9,1);
  errors NUMBER;
  dml_errors EXCEPTION;
  PRAGMA exception_init(dml_errors, -24381);
BEGIN
  FORALL i IN num_tab.FIRST..num_tab.LAST SAVE EXCEPTIONS
    DELETE FROM employees WHERE salary > 50000/num_tab(i);
EXCEPTION
  WHEN dml_errors THEN
    errors := SQL%BULK_EXCEPTIONS.COUNT;
    dbms_output.put_line('Number of errors is ' || errors);
    FOR i IN 1..errors
    LOOP
      dbms_output.put_line('Error ' || i || ' occurred during '||
        'iteration ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX);
     dbms_output.put_line('Oracle error is ' ||
        SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
    END LOOP;
END;
/ 
