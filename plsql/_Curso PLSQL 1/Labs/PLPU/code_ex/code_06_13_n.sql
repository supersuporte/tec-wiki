REM
REM The examples with prodedure list_employees, and package mypack
REM are commented out as these objects do not exists they are syntax
REM only examples. YOu must create these object for the compile to work.
REM

REM EXEC compile_plsql ('list_employees', 'procedure')
EXEC compile_plsql ('get_emp', 'function')
REM EXEC compile_plsql ('mypack', 'package', 'specification') 
REM EXEC compile_plsql ('mypack', 'package', 'body')

-- Compiling with DEBUG enabled for the get_employee function:
EXEC compile_plsql ('get_emp', 'function', 'debug')
