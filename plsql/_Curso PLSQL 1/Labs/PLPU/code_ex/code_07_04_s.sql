CREATE OR REPLACE PACKAGE error_pkg IS
  fk_err	     EXCEPTION;
  seq_nbr_err	EXCEPTION;
  PRAGMA EXCEPTION_INIT (fk_err, -2292);
  PRAGMA EXCEPTION_INIT (seq_nbr_err, -2277);
  --
END error_pkg;
/
