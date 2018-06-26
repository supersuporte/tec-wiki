--
-- This must be executed as a DBA or TEACH. Replace the <path> with the
--  pathname to your ORACLE_HOME
--
-- host mkdir <path>/plsql_libs
-- alter system set plsql_native_library_dir = '<path>/plsql_libs';
-- For example:
--
alter system set plsql_native_library_dir = '&ORACLE_HOME/plsql_libs';
