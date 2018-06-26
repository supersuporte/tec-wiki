CREATE OR REPLACE PACKAGE forward_pkg IS
  PROCEDURE award_bonus;
END forward_pkg;
/

REM
REM This part should generate a compiler error.
REM
CREATE OR REPLACE PACKAGE BODY forward_pkg IS
  PROCEDURE award_bonus IS
  BEGIN
    calc_rating;    --illegal reference
  END;
  
  PROCEDURE calc_rating IS
  BEGIN
    NULL;
  END;
END forward_pkg;
/

REM
REM This example fixes the package body compilation error
REM
CREATE OR REPLACE PACKAGE BODY forward_pkg IS
 PROCEDURE calc_rating; -- forward declaration  

 -- Subprograms defined in alphabetical order

 PROCEDURE award_bonus IS
 BEGIN
   calc_rating;        -- reference resolved!
 END;
 
 PROCEDURE calc_rating IS -- implementation
 BEGIN
   NULL;
 END;
END forward_pkg;
/
