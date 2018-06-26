BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento_periodo',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO_PERIODO',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=MON; BYHOUR=12; BYMINUTE=10; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento_periodo');
END;


BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento01',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO01',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=SAT; BYHOUR=18; BYMINUTE=10; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento01');
END;


BEGIN
    DBMS_SCHEDULER.DROP_JOB('fechamento_mensal');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento_mensal',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO_MENSAL',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=DAILY; BYHOUR=6,12; BYMINUTE=15; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento_mensal');
END;

BEGIN
    DBMS_SCHEDULER.DROP_JOB('fechamento_mensal');
END;



BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento02',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO02',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=MON; BYHOUR=12; BYMINUTE=10; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento02');
END;



BEGIN
    --------------------
    -- VENDAS LIQUIDA --
    --------------------
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_vlt',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.VENDAS_LIQUIDA',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=THU; BYHOUR=5; BYMINUTE=30; BYSECOND=0',
        number_of_arguments=>  2);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vlt', 1, '01/05/2016');
    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vlt', 2, '31/05/2016');

    DBMS_SCHEDULER.ENABLE('job_bi_vlt');

    --------------------------------
    -- VENDAS LIQUIDA POR PRODUTO --
    --------------------------------
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_vlpt',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.VENDAS_LIQUIDA_PRODUTO',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=THU; BYHOUR=5; BYMINUTE=30; BYSECOND=0',
        number_of_arguments=>  2);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vlpt', 1, '01/05/2016');
    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vlpt', 2, '31/05/2016');

    DBMS_SCHEDULER.ENABLE('job_bi_vlpt');

    ------------------------
    -- MATERIALIZED VIEWS --
    ------------------------
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_mvt',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.ATUALIZA_FECHAMENTO_MVIEWS',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=THU; BYHOUR=5; BYMINUTE=30; BYSECOND=0',
        number_of_arguments=>  1);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_mvt', 1, '');

    DBMS_SCHEDULER.ENABLE('job_bi_mvt');

END;




BEGIN
    --------------------
    -- VENDAS LIQUIDA --
    --------------------
    DBMS_SCHEDULER.DROP_JOB('job_bi_vendas_liquida');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_vendas_liquida',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.VENDAS_LIQUIDA',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=DAILY; BYHOUR=6,12; BYMINUTE=50; BYSECOND=0',
        number_of_arguments=>  2);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vendas_liquida', 1, '');
    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vendas_liquida', 2, '');

    DBMS_SCHEDULER.ENABLE('job_bi_vendas_liquida');
    
    
    DBMS_SCHEDULER.DROP_JOB('job_bi_cutoff');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_cutoff',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.CUTOFF',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=MONTHLY; BYMONTHDAY=1; BYHOUR=6; BYMINUTE=51; BYSECOND=0',
        number_of_arguments=>  1);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_cutoff', 1, '');

    DBMS_SCHEDULER.ENABLE('job_bi_cutoff');


    --------------------------------
    -- VENDAS LIQUIDA POR PRODUTO --
    --------------------------------
    DBMS_SCHEDULER.DROP_JOB('job_bi_vendas_liquida_prod');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_vendas_liquida_prod',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.VENDAS_LIQUIDA_PRODUTO',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=DAILY; BYHOUR=6,12; BYMINUTE=52; BYSECOND=0',
        number_of_arguments=>  2);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vendas_liquida_prod', 1, '');
    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_vendas_liquida_prod', 2, '');

    DBMS_SCHEDULER.ENABLE('job_bi_vendas_liquida_prod');



    DBMS_SCHEDULER.DROP_JOB('job_bi_cutoff_produto');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_cutoff_produto',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.CUTOFF_PRODUTO',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=MONTHLY; BYMONTHDAY=1; BYHOUR=6; BYMINUTE=53; BYSECOND=0',
        number_of_arguments=>  1);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_cutoff_produto', 1, '');

    DBMS_SCHEDULER.ENABLE('job_bi_cutoff_produto');


    -------------------
    -- PRAZOS MEDIOS --
    -------------------
    DBMS_SCHEDULER.DROP_JOB('job_bi_prazos_medios');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_prazos_medios',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_PRAZO_MEDIO.PRAZOS_MEDIOS',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=MONTHLY; BYDAY=MON,TUE,WED,THU,FRI; BYSETPOS=2,3,4,5; BYHOUR=6; BYMINUTE=40; BYSECOND=0',
        number_of_arguments=>  0);

    DBMS_SCHEDULER.ENABLE('job_bi_prazos_medios');


    ------------------------
    -- MATERIALIZED VIEWS --
    ------------------------
    DBMS_SCHEDULER.DROP_JOB('job_bi_mat_view');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'job_bi_mat_view',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI.ATUALIZA_FECHAMENTO_MVIEWS',
        start_date         =>  SYSTIMESTAMP,
        repeat_interval    =>  'FREQ=DAILY; BYHOUR=6,12; BYMINUTE=55; BYSECOND=0',
        number_of_arguments=>  1);

    DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE('job_bi_mat_view', 1, '');

    DBMS_SCHEDULER.ENABLE('job_bi_mat_view');

END;







SELECT job_name, repeat_interval, job_action, run_count, failure_count, 
last_start_date, last_run_duration, next_run_date
FROM USER_SCHEDULER_JOBS;

SELECT * FROM USER_SCHEDULER_JOB_LOG where to_char(log_date, 'dd/mm/yyyy') = '01/09/2017';

SELECT to_char(log_date, 'DD-MON-YY HH24:MM:SS') TIMESTAMP, job_name, status,
   SUBSTR(additional_info, 1, 40) ADDITIONAL_INFO
   FROM user_scheduler_job_run_details ORDER BY log_date desc;

SELECT * FROM USER_SCHEDULER_RUNNING_JOBS;

BEGIN
    dbms_scheduler.stop_job('FECHAMENTO_MENSAL');
END;


/*
exec sys.dbms_scheduler.DROP_JOB('job_bi_vendas_liquida');
exec sys.dbms_scheduler.DROP_JOB('job_bi_mat_view');
exec sys.dbms_scheduler.DROP_JOB('job_bi_prazos_medios');
exec sys.dbms_scheduler.DROP_JOB('job_bi_cutoff_produto');
exec sys.dbms_scheduler.DROP_JOB('job_bi_vendas_liquida_prod');
exec sys.dbms_scheduler.DROP_JOB('job_bi_cutoff');
*/

SELECT * FROM USER_SCHEDULER_JOB_LOG where job_name LIKE 'JOB_BI%' ORDER BY LOG_DATE DESC;

SELECT * FROM USER_SCHEDULER_JOB_LOG where STATUS = 'RUNNING';

SELECT * FROM USER_SCHEDULER_JOB_LOG where job_name LIKE '%FECHA%' ORDER BY LOG_DATE DESC;

select value from v$parameter where name='job_queue_processes';

select value from dba_scheduler_global_attribute
where attribute_name='MAX_JOB_SLAVE_PROCESSES';

select value from v$parameter where name='sessions';


select codigo, processo, inicio_fechamento, fim_fechamento, 
  to_char(inicio_processamento, 'DD/MM/YYYY HH24:MI:SS'), 
  to_char(fim_processamento, 'DD/MM/YYYY HH24:MI:SS') 
from bilog order by codigo desc;

delete from bilog where FIM_PROCESSAMENTO is null;
COMMIT;

---------------------------------------------------------------------------------

create or replace 
PACKAGE BODY PACK_BI_OFF
IS

 PROCEDURE fechamento01 as
 begin

    PACK_BI.vendas_liquida('01/01/2013','24/09/2017');
    PACK_BI.vendas_liquida_produto('01/01/2013','24/09/2017');
    
    PACK_BI.cutoff('01/01/2013');
    PACK_BI.cutoff_produto('01/01/2013');
    PACK_BI.cutoff('01/02/2013');
    PACK_BI.cutoff_produto('01/02/2013');
    PACK_BI.cutoff('01/03/2013');
    PACK_BI.cutoff_produto('01/03/2013');
    PACK_BI.cutoff('01/04/2013');
    PACK_BI.cutoff_produto('01/04/2013');
    PACK_BI.cutoff('01/05/2013');
    PACK_BI.cutoff_produto('01/05/2013');
    PACK_BI.cutoff('01/06/2013');
    PACK_BI.cutoff_produto('01/06/2013');
    PACK_BI.cutoff('01/07/2013');
    PACK_BI.cutoff_produto('01/07/2013');
    PACK_BI.cutoff('01/08/2013');
    PACK_BI.cutoff_produto('01/08/2013');
    PACK_BI.cutoff('01/09/2013');
    PACK_BI.cutoff_produto('01/09/2013');
    PACK_BI.cutoff('01/10/2013');
    PACK_BI.cutoff_produto('01/10/2013');
    PACK_BI.cutoff('01/11/2013');
    PACK_BI.cutoff_produto('01/11/2013');
    PACK_BI.cutoff('01/12/2013');
    PACK_BI.cutoff_produto('01/12/2013');
    
    PACK_BI.cutoff('01/01/2014');
    PACK_BI.cutoff_produto('01/01/2014');
    PACK_BI.cutoff('01/02/2014');
    PACK_BI.cutoff_produto('01/02/2014');
    PACK_BI.cutoff('01/03/2014');
    PACK_BI.cutoff_produto('01/03/2014');
    PACK_BI.cutoff('01/04/2014');
    PACK_BI.cutoff_produto('01/04/2014');
    PACK_BI.cutoff('01/05/2014');
    PACK_BI.cutoff_produto('01/05/2014');
    PACK_BI.cutoff('01/06/2014');
    PACK_BI.cutoff_produto('01/06/2014');
    PACK_BI.cutoff('01/07/2014');
    PACK_BI.cutoff_produto('01/07/2014');
    PACK_BI.cutoff('01/08/2014');
    PACK_BI.cutoff_produto('01/08/2014');
    PACK_BI.cutoff('01/09/2014');
    PACK_BI.cutoff_produto('01/09/2014');
    PACK_BI.cutoff('01/10/2014');
    PACK_BI.cutoff_produto('01/10/2014');
    PACK_BI.cutoff('01/11/2014');
    PACK_BI.cutoff_produto('01/11/2014');
    PACK_BI.cutoff('01/12/2014');
    PACK_BI.cutoff_produto('01/12/2014');
    
    PACK_BI.cutoff('01/01/2015');
    PACK_BI.cutoff_produto('01/01/2015');
    PACK_BI.cutoff('01/02/2015');
    PACK_BI.cutoff_produto('01/02/2015');
    PACK_BI.cutoff('01/03/2015');
    PACK_BI.cutoff_produto('01/03/2015');
    PACK_BI.cutoff('01/04/2015');
    PACK_BI.cutoff_produto('01/04/2015');
    PACK_BI.cutoff('01/05/2015');
    PACK_BI.cutoff_produto('01/05/2015');
    PACK_BI.cutoff('01/06/2015');
    PACK_BI.cutoff_produto('01/06/2015');
    PACK_BI.cutoff('01/07/2015');
    PACK_BI.cutoff_produto('01/07/2015');
    PACK_BI.cutoff('01/08/2015');
    PACK_BI.cutoff_produto('01/08/2015');
    PACK_BI.cutoff('01/09/2015');
    PACK_BI.cutoff_produto('01/09/2015');
    PACK_BI.cutoff('01/10/2015');
    PACK_BI.cutoff_produto('01/10/2015');
    PACK_BI.cutoff('01/11/2015');
    PACK_BI.cutoff_produto('01/11/2015');
    PACK_BI.cutoff('01/12/2015');
    PACK_BI.cutoff_produto('01/12/2015');
    
    PACK_BI.cutoff('01/01/2016');
    PACK_BI.cutoff_produto('01/01/2016');
    PACK_BI.cutoff('01/02/2016');
    PACK_BI.cutoff_produto('01/02/2016');
    PACK_BI.cutoff('01/03/2016');
    PACK_BI.cutoff_produto('01/03/2016');
    PACK_BI.cutoff('01/04/2016');
    PACK_BI.cutoff_produto('01/04/2016');
    PACK_BI.cutoff('01/05/2016');
    PACK_BI.cutoff_produto('01/05/2016');
    PACK_BI.cutoff('01/06/2016');
    PACK_BI.cutoff_produto('01/06/2016');
    PACK_BI.cutoff('01/07/2016');
    PACK_BI.cutoff_produto('01/07/2016');
    PACK_BI.cutoff('01/08/2016');
    PACK_BI.cutoff_produto('01/08/2016');
    PACK_BI.cutoff('01/09/2016');
    PACK_BI.cutoff_produto('01/09/2016');
    PACK_BI.cutoff('01/10/2016');
    PACK_BI.cutoff_produto('01/10/2016');
    PACK_BI.cutoff('01/11/2016');
    PACK_BI.cutoff_produto('01/11/2016');
    PACK_BI.cutoff('01/12/2016');
    PACK_BI.cutoff_produto('01/12/2016');
    
    PACK_BI.cutoff('01/01/2017');
    PACK_BI.cutoff_produto('01/01/2017');
    PACK_BI.cutoff('01/02/2017');
    PACK_BI.cutoff_produto('01/02/2017');
    PACK_BI.cutoff('01/03/2017');
    PACK_BI.cutoff_produto('01/03/2017');
    PACK_BI.cutoff('01/04/2017');
    PACK_BI.cutoff_produto('01/04/2017');
    PACK_BI.cutoff('01/05/2017');
    PACK_BI.cutoff_produto('01/05/2017');
    PACK_BI.cutoff('01/06/2017');
    PACK_BI.cutoff_produto('01/06/2017');
    PACK_BI.cutoff('01/07/2017');
    PACK_BI.cutoff_produto('01/07/2017');
    PACK_BI.cutoff('01/08/2017');
    PACK_BI.cutoff_produto('01/08/2017');
    PACK_BI.cutoff('01/09/2017');
    PACK_BI.cutoff_produto('01/09/2017');
    
    --pack_bi_prazo_medio.prazo_medio_vendas(08,2017,08,2017);
    --pack_bi_prazo_medio.prazo_medio_recebimento(08,2017,08,2017);
    --pack_bi_prazo_medio.novo_prazo_medio_rec(03,2017,08,2017);

    pack_bi.atualiza_fechamento_mviews('');
 
 end fechamento01;


 PROCEDURE fechamento02 as
 begin
  -- pack_bi_prazo_medio.novo_prazo_medio_rec(03,2017,08,2017);
  
  PACK_BI.vendas_liquida('01/09/2017','30/09/2017');
  PACK_BI.vendas_liquida_produto('01/09/2017','30/09/2017');
    
  PACK_BI.cutoff('01/09/2017');
  PACK_BI.cutoff_produto('01/09/2017');
  
  PACK_BI.cutoff('01/10/2017');
  PACK_BI.cutoff_produto('01/10/2017');
  
  pack_bi.atualiza_fechamento_mviews('');
 end fechamento02;
 
 PROCEDURE atualiza_familias as
 begin
    
    -- executou em 20s
    update cbt1397 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 45k linhas
    update cbt1397 set cod_familia = 'EC' where cod_familia = 'OP'; -- 37k linhas
    update cbt1397 set cod_familia = 'OM' where cod_familia = 'XX'; -- 500 linhas
    
    -- executou em 2s
    update cbt1396 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 6k linhas
    update cbt1396 set cod_familia = 'EC' where cod_familia = 'OP'; -- 6k linhas
    update cbt1396 set cod_familia = 'OM' where cod_familia = 'XX'; -- 100 linhas
    
    -- executou em 1s
    update iat177 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 40 linhas
    update iat177 set cod_familia = 'EC' where cod_familia = 'OP'; -- 10 linhas
    update iat177 set cod_familia = 'OM' where cod_familia = 'XX'; -- 30 linhas
    
    update iat084 set cod_familia = 'MS' where cod_familia = 'LZ';
    update iat084 set cod_familia = 'EC' where cod_familia = 'OP';
    update iat084 set cod_familia = 'OM' where cod_familia = 'XX';
    
    commit;
    
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 1999;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2000;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2001;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2002;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2003;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2004;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2005;
    commit;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2006;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2007;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2008;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2009;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2010;
    commit;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2011;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2012;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2013;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2014;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2015;
    update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2016;
    commit;
    
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 1999;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2000;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2001;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2002;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2003;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2004;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2005;
    commit;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2006;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2007;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2008;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2009;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2010;
    commit;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2011;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2012;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2013;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2014;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2015;
    update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2016;
    commit;
    
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 1999;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2000;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2001;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2002;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2003;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2004;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2005;
    commit;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2006;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2007;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2008;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2009;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2010;
    commit;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2011;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2012;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2013;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2014;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2015;
    update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2016;
    commit;
    
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2010;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2011;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2012;
    commit;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2013;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2014;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2015;
    update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2016;
    commit;
    
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2010;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2011;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2012;
    commit;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2013;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2014;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2015;
    update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2016;
    commit;
    
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2010;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2011;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2012;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2013;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2014;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2015;
    update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2016;
    commit;
    
    pack_bi.atualiza_fechamento_mviews('');
     
 end atualiza_familias;
 
 PROCEDURE fechamento_periodo as
 begin
/*
    PACK_BI.vendas_liquida('01/06/2017','30/06/2017');
    PACK_BI.vendas_liquida_produto('01/06/2017','30/06/2017');
 
    PACK_BI.cutoff('01/06/2017');
    PACK_BI.cutoff_produto('01/06/2017');
    PACK_BI.cutoff('01/07/2017');
    PACK_BI.cutoff_produto('01/07/2017');

    pack_bi_prazo_medio.prazo_medio_vendas(06,2017,06,2017);
    pack_bi_prazo_medio.prazo_medio_recebimento(06,2017,06,2017);
*/
    pack_bi_prazo_medio.novo_prazo_medio_rec(07,2017,08,2017);

    --pack_bi.atualiza_fechamento_mviews('');
 
 end fechamento_periodo;
 
 PROCEDURE fechamento_mensal as
    mesAno_anterior    VARCHAR2(12);
    primeiro_dia_util  DATE;
 BEGIN
    mesAno_anterior      := to_char(add_months(TRUNC(TO_DATE(SYSDATE,'DD/MM/YYYY'),'MM'),-1),'MM/YYYY');
    primeiro_dia_util    := first_work_day(SYSDATE);

    IF (to_char(SYSDATE,'DD/MM/YYYY') = to_char(primeiro_dia_util,'DD/MM/YYYY')) THEN
      PACK_BI.vendas_liquida('01/'||mesAno_anterior,to_char(LAST_DAY('01/'||mesAno_anterior),'DD/MM/YYYY'));
      PACK_BI.vendas_liquida_produto('01/'||mesAno_anterior,to_char(LAST_DAY('01/'||mesAno_anterior),'DD/MM/YYYY'));
   
      PACK_BI.cutoff('01/'||mesAno_anterior);
      PACK_BI.cutoff_produto('01/'||mesAno_anterior);
      PACK_BI.cutoff('01'||to_char(SYSDATE, 'MM/YYYY'));
      PACK_BI.cutoff_produto('01'||to_char(SYSDATE, 'MM/YYYY'));
  
      pack_bi_prazo_medio.prazo_medio_vendas(to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                             to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                             to_number(to_char(SYSDATE, 'MM')),
                                             to_number(to_char(SYSDATE, 'YYYY')));
      pack_bi_prazo_medio.prazo_medio_recebimento(to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                                  to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                                  to_number(to_char(SYSDATE, 'MM')),
                                                  to_number(to_char(SYSDATE, 'YYYY')));
      pack_bi_prazo_medio.novo_prazo_medio_rec(to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                               to_number(to_char(TO_DATE('01/'||mesAno_anterior, 'DD/MM/YYYY'), 'MM')),
                                               to_number(to_char(SYSDATE, 'MM')),
                                               to_number(to_char(SYSDATE, 'YYYY')));
  
      pack_bi.atualiza_fechamento_mviews('');
      
      INSERT INTO bilog (CODIGO,
                         INICIO_PROCESSAMENTO,
                         FIM_PROCESSAMENTO,
                         INICIO_FECHAMENTO,
                         FIM_FECHAMENTO,
                         PROCESSO)
             VALUES (BILOG_CODIGO.NEXTVAL,
                     SYSDATE, 
                     SYSDATE,
                     TO_DATE('01/'||mesAno_anterior,'DD/MM/YYYY'),
                     LAST_DAY('01/'||mesAno_anterior),
                     'FECHAMENTO MENSAL');
    END IF;
 END fechamento_mensal;

END PACK_BI_OFF;



