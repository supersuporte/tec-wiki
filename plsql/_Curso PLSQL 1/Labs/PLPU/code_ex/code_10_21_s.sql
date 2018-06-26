REM
REM **** NOTE ****
REM PLEASE EXECUTE THIS AFTER CREATING THE emp_details VIEW
REM The view is and its related tables is created when you
REM execute the for 
REM 1) code_10_22_s.sql (first) AND then
REM 2) code_10_23_n.sql (next)
REM before running this script!!!
REM **** NOTE ****
REM

INSERT INTO emp_details
VALUES (9001,'ABBOTT',3000, 10, 'Administration');

REM
REM Uncomment the following SELECT statements to check the results
REM
-- SELECT * FROM new_depts where department_id = 10;
-- SELECT * FROM new_emps where department_id= 10;
