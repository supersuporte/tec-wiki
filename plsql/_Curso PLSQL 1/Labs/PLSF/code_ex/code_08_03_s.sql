SET SERVEROUTPUT ON
DECLARE
  lname VARCHAR2(15);
BEGIN
  SELECT last_name INTO lname FROM employees WHERE     
  first_name='John'; 
  DBMS_OUTPUT.PUT_LINE ('John''s last name is : ' ||lname);
END;



