CREATE OR REPLACE FUNCTION f2 (p1 NUMBER) 
  RETURN NUMBER PARALLEL_ENABLE IS 
BEGIN 
  RETURN p1 * 2; 
END f2;
/