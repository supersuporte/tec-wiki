SET SERVEROUTPUT ON
REM
REM The first two execute commands here are not shown in the 
REM slide example, and WILL generate the following exception:
REM    ORA-06502: PL/SQL numeric or value error 
REM This is a workaroundfor a bug in iSQL*PLus or the HTP package.
REM
EXECUTE htp.print('demo')
EXECUTE owa_util.showpage
REM
REM This should now work! Without change
REM
BEGIN
  htp.bold('Hello');             -- <B>Hello</B>
  htp.print('Hi <B>World</B>');  -- Hi <B>World</B>
END;
/
EXECUTE OWA_UTIL.SHOWPAGE
