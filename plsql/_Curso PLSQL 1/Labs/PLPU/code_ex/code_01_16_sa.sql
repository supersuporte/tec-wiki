CREATE OR REPLACE PROCEDURE add_dept(
 name departments.department_name%TYPE:='Unknown',
 loc  departments.location_id%TYPE DEFAULT 1700) IS
BEGIN
  INSERT INTO departments (department_id, department_name, location_id)
  VALUES (departments_seq.NEXTVAL, name, loc);
END add_dept;
/
