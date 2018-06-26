ALTER TABLE employees ADD video BFILE;

UPDATE employees
  SET video = BFILENAME('MEDIA_FILES', 'King.avi')
WHERE employee_id = 100;
