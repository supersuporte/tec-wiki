select data, sum(valor), sum(quantidade)
from bi0100
where data >= '13/04/2015' group by data
order by data desc
;

SELECT * FROM USER_SCHEDULER_JOBS;
SELECT JOB_NAME, start_date, NEXT_RUN_DATE,  end_date FROM USER_SCHEDULER_JOBS;

select codigo,
processo,
inicio_fechamento,
fim_fechamento,
to_char(inicio_processamento, 'dd/mm/yyyy hh:mi:ss') inicio_processamento,
to_char(fim_processamento, 'dd/mm/yyyy hh:mi:ss') fim_processamento
from bilog 
order by codigo desc;


SELECT job_name, repeat_interval, job_action, run_count, failure_count, 
last_start_date, last_run_duration, next_run_date
FROM USER_SCHEDULER_JOBS;

SELECT * FROM USER_SCHEDULER_JOB_LOG where job_name LIKE 'JOB_BI%' ORDER BY LOG_DATE DESC;


select max(data) vendas_liquida from bi0100;
select max(data) vendas_liquida_produto from bi0110;
select max(data) cutoff from bi0200;
select max(data) cutoff_produto from bi0210;
select max(data) vendas_liquida_repres from biv101;
select max(data) vendas_liquida_gerencia from biv103;
