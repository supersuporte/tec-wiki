SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
  fname VARCHAR2(15):='&fname';
  lname VARCHAR2(15);
BEGIN
  SELECT last_name INTO lname FROM employees WHERE     
  LOWER(first_name)=LOWER(fname); 
  DBMS_OUTPUT.PUT_LINE (fname||'''s last name is : ' ||lname);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
  DBMS_OUTPUT.PUT_LINE (' Your select statement retrieved multiple
  rows, consider using a cursor');

  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE (' Sorry! The search did not retrieve any  
  row. Please try with a different data');   
END;





