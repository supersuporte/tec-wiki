REM
REM Please replace the 'HR' value in ALL examples
REM with your username (schema name), for example: 'TEACH', or 'ORA1' and so on.
REM
SELECT DBMS_METADATA.GET_XML('TABLE', 'EMPLOYEES', 'HR')
FROM   dual;

SELECT DBMS_METADATA.GET_DEPENDENT_DDL('OBJECT_GRANT', 'EMPLOYEES', 'HR')
FROM   dual;

SELECT DBMS_METADATA.GET_GRANTED_DDL ('SYSTEM_GRANT', 'HR')
FROM   dual;
