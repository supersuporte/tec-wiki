DECLARE
 salary NUMBER(6):=6000;
 sal_hike VARCHAR2(5):='1000';
 total_salary salary%TYPE;
BEGIN
 total_salary:=salary+sal_hike;
END;

