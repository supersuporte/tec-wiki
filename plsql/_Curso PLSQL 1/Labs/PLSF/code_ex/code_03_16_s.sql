<<outer>>
DECLARE
 father_name VARCHAR2(20):='Patrick';
 date_of_birth DATE:='20-Apr-1972';
BEGIN
  DECLARE
   child_name VARCHAR2(20):='Mike';
   date_of_birth DATE:='12-Dec-2002';
  BEGIN
   DBMS_OUTPUT.PUT_LINE('Father''s Name: '||father_name);
   DBMS_OUTPUT.PUT_LINE('Date of Birth: '
                        ||outer.date_of_birth);
   DBMS_OUTPUT.PUT_LINE('Child''s Name: '||child_name);
   DBMS_OUTPUT.PUT_LINE('Date of Birth: '||date_of_birth);
  END;
END;
