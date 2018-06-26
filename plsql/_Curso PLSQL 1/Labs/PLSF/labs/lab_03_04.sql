VARIABLE basic_percent NUMBER
VARIABLE pf_percent NUMBER

-- Include PROMPT command here

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
   empno NUMBER(6);  -- Modify the declaration to accept the user input.
   fname VARCHAR2(15);
   emp_sal NUMBER(10);
BEGIN
   :basic_percent:=45;
   :pf_percent:=12; 

-- Modify the select statement to include substitution variable empno

   SELECT first_name, salary INTO fname, emp_sal
   FROM employees WHERE employee_id=110;

   DBMS_OUTPUT.PUT_LINE(' Hello '|| fname);
   DBMS_OUTPUT.PUT_LINE('YOUR SALARY IS : '||emp_sal);
   DBMS_OUTPUT.PUT_LINE('YOUR CONTRIBUTION TOWARDS PF:     
   '||emp_sal*:basic_percent/100*:pf_percent/100);
END;




