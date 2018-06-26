SET SERVEROUTPUT ON
DECLARE
  CURSOR emp_cursor (deptno NUMBER) IS
   SELECT employee_id, last_name
   FROM   employees
   WHERE  department_id = deptno;    
BEGIN
   DBMS_OUTPUT.PUT_LINE('Printing employee number and last names of  
   employees working in department number 10');
   FOR emp_record IN emp_cursor (10)
      LOOP
      DBMS_OUTPUT.PUT_LINE( emp_record.employee_id || ' ' || 
      emp_record.last_name);
      END LOOP;

   DBMS_OUTPUT.PUT_LINE('Printing employee number and last names of  
   employees working in department number 20');
   FOR emp_record IN emp_cursor (20)
      LOOP
      DBMS_OUTPUT.PUT_LINE( emp_record.employee_id || ' ' || 
      emp_record.last_name);
      END LOOP;      
END;


