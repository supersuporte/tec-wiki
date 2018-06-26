VARIABLE name	VARCHAR2(25)
VARIABLE sal	NUMBER
EXECUTE query_emp(171, :name, :sal)
PRINT name sal
