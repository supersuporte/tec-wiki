CREATE OR REPLACE PACKAGE dept_pkg IS
  PROCEDURE add_department(deptno NUMBER, name VARCHAR2 := 'unknown', loc NUMBER := 1700);
  PROCEDURE add_department(name VARCHAR2 := 'unknown', loc  NUMBER := 1700);
END dept_pkg;
/
