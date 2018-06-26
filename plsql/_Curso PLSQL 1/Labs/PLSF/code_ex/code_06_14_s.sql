SET SERVEROUTPUT ON
SET VERIFY OFF

DEFINE employee_number = 124
DECLARE
   emp_rec  retired_emps%ROWTYPE;
BEGIN
 SELECT * INTO emp_rec FROM retired_emps;
 emp_rec.leavedate:=SYSDATE;
 UPDATE retired_emps SET ROW = emp_rec WHERE 
  empno=&employee_number;
END;

/

SELECT * FROM retired_emps;





