call PACK_BI.vendas_liquida('12/09/2017','12/09/2017');
call PACK_BI.vendas_liquida_produto('12/09/2017','12/09/2017');

call PACK_BI.cutoff('01/09/2017');
call PACK_BI.cutoff('01/10/2017');
call PACK_BI.cutoff_produto('01/09/2017');
call PACK_BI.cutoff_produto('01/10/2017');
/*
call pack_bi_prazo_medio.prazo_medio_vendas(06,2017,08,2017);
call pack_bi_prazo_medio.prazo_medio_recebimento(03,2017,08,2017);
call pack_bi_prazo_medio.novo_prazo_medio_rec(03,2017,08,2017);
*/
call DBMS_MVIEW.REFRESH('BIV101');
call DBMS_MVIEW.REFRESH('BIV103');

-- dias a fechar: 



SELECT job_name, repeat_interval, job_action, run_count, failure_count, 
last_start_date, last_run_duration, next_run_date
FROM USER_SCHEDULER_JOBS;

SELECT * FROM USER_SCHEDULER_JOB_LOG where to_char(log_date, 'dd/mm/yyyy') = '01/08/2017';

SELECT to_char(log_date, 'DD-MON-YY HH24:MM:SS') TIMESTAMP, job_name, status,
   SUBSTR(additional_info, 1, 40) ADDITIONAL_INFO
   FROM user_scheduler_job_run_details ORDER BY log_date desc;

SELECT * FROM USER_SCHEDULER_RUNNING_JOBS;

BEGIN
    dbms_scheduler.stop_job('FECHAMENTO_MENSAL');
END;
