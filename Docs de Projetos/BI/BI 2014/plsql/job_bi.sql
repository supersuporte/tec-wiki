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
        number_of_arguments=>  0);

    DBMS_SCHEDULER.ENABLE('job_bi_mat_view');

END;
