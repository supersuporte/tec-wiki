BEGIN
  --DBMS_SCHEDULER.DROP_JOB('JOB_MESSAGES');
  DBMS_SCHEDULER.CREATE_JOB(
    job_name => 'JOB_MESSAGES',
    job_type => 'PLSQL_BLOCK',
    job_action => '
      BEGIN
        INSERT INTO MESSAGES VALUES(TO_CHAR(SYSDATE,''dd/mm/yyyy hh24:mi''));
        COMMIT;
      END;',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQUENCY=MINUTELY;INTERVAL=1',
    enabled => TRUE);    

END;
/