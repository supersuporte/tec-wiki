Alter trigger UPDATE_JOB_HISTORY DISABLE;
DROP TRIGGER employee_dept_fk_trg;
SELECT *
FROM DEPARTMENTS
WHERE department_id = 15;

UPDATE employees
 SET department_id = 15
 WHERE employee_id = 170;

CREATE OR REPLACE TRIGGER employee_dept_fk_trg
AFTER UPDATE OF department_id
ON employees FOR EACH ROW
BEGIN
 INSERT INTO departments VALUES(:new.department_id,
    'Dept '||:new.department_id, NULL, NULL);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
    NULL; -- mask exception if department exists
    DBMS_OUTPUT.PUT_LINE(:new.department_id||' already exists');
END;
/
UPDATE employees
 SET department_id = 15
 WHERE employee_id = 170;

SELECT *
FROM DEPARTMENTS
WHERE department_id = 15;

UPDATE employees
 SET department_id = 15
 WHERE employee_id = 100;

ROLLBACK;
DROP TRIGGER employee_dept_fk_trg;
Alter trigger UPDATE_JOB_HISTORY ENABLE;