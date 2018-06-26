alter session set plsql_compiler_flags = 'NATIVE';

SELECT param_value, object_name
FROM   user_stored_settings
WHERE  param_name = 'PLSQL_COMPILER_FLAGS';
