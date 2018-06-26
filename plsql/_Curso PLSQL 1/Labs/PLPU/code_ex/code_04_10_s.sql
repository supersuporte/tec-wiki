REM This is an non executable code

CREATE OR REPLACE PACKAGE taxes IS
  tax   NUMBER;
  -- declare all public procedures/functions
END taxes;
/
CREATE OR REPLACE PACKAGE BODY taxes IS
  -- declare all private variables
  -- define public/private procedures/functions
 BEGIN
   SELECT   rate_value INTO tax
   FROM     tax_rates
   WHERE    rate_name = 'TAX';
END taxes;
/
