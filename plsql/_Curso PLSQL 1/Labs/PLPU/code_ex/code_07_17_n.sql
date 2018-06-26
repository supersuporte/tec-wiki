CREATE TABLE num_table (n NUMBER);
DECLARE
  TYPE NumList IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  nums NumList;
BEGIN
  nums(1) := 1;
  nums(2) := 3;
  nums(3) := 5;
  nums(4) := 7;
  nums(5) := 11;
  FORALL i IN nums.FIRST .. nums.LAST
    INSERT INTO num_table (n) VALUES (nums(i));
  FOR i IN nums.FIRST .. nums.LAST
  LOOP
    dbms_output.put_line('Inserted ' || 
      SQL%BULK_ROWCOUNT(i) || ' row(s)'
      || ' on iteration ' || i);
  END LOOP;
END;
/
DROP TABLE num_table;
