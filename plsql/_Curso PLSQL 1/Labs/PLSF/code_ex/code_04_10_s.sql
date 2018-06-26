SET SERVEROUTPUT ON
DECLARE    
   sum_sal   NUMBER(10,2); 
   deptno      NUMBER NOT NULL := 60;           
BEGIN
   SELECT	SUM(salary)  -- group function
   INTO sum_sal  FROM	employees
   WHERE     department_id = deptno;
   DBMS_OUTPUT.PUT_LINE ('The sum of salary is ' || sum_sal);
END;

