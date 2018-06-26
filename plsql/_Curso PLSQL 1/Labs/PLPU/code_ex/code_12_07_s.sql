-- If you are a DBA user
REM ALTER SYSTEM SET plsql_compiler_flags='NATIVE';
REM ALTER SYSTEM SET plsql_compiler_flags='INTERPRETED';

-- Any user
ALTER SESSION SET plsql_compiler_flags='NATIVE';
ALTER SESSION SET plsql_compiler_flags='INTERPRETED';
