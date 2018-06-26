SET SERVEROUTPUT ON
REM
REM Please execute the demo file called:
REM   E:\labs\PLPU\demo\demo_05_web_emp.sql to create
REM a procedure called web_emp.  Use the name Web_emp in the prompt
REM for a Procedure name.
REM
ACCEPT procname PROMPT "Procedure: "
EXECUTE &procname
EXECUTE owa_util.showpage
UNDEFINE proc
