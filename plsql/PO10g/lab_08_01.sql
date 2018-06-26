--SET SERVEROUTPUT ON;
--DEFINE sal = 6000;
--DEFINE sal = 5000;
--DEFINE sal = 4400;

DECLARE
  ename   employees.last_name%TYPE;
  emp_sal employees.salary%TYPE;
 
BEGIN
  SELECT last_name,salary
  INTO   ename,emp_sal
  FROM   employees
  WHERE  salary = &sal;  
  
  INSERT INTO messages VALUES ('Sal�rio de ' || ename || ': ' || &sal);
  COMMIT;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    INSERT INTO messages VALUES ('Nenhum empregado com sal�rio de ' || &sal);
    COMMIT;

  WHEN TOO_MANY_ROWS THEN
    INSERT INTO messages VALUES ('Mais de um empregado com sal�rio de ' || &sal);
    COMMIT;
    
  WHEN OTHERS THEN
    INSERT INTO messages VALUES ('Erro desconhecido.');
    COMMIT;

END;
/