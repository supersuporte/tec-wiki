SET SERVEROUTPUT ON
DECLARE
  bf_var BINARY_FLOAT;
  bd_var BINARY_DOUBLE;
BEGIN
  bf_var := 270/35f;
  bd_var := 140d/0.35;
  DBMS_OUTPUT.PUT_LINE('bf: '|| bf_var);
  DBMS_OUTPUT.PUT_LINE('bd: '|| bd_var);
END;
