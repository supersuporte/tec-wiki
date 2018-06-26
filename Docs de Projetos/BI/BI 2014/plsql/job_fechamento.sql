BEGIN
    DBMS_SCHEDULER.DROP_JOB('fechamento_bi_01');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento_bi_01',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO01',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=SAT; BYHOUR=4; BYMINUTE=0; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento_bi_01');

END;


BEGIN
    DBMS_SCHEDULER.DROP_JOB('fechamento_bi_02');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'fechamento_bi_02',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.FECHAMENTO02',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=MON; BYHOUR=4; BYMINUTE=0; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('fechamento_bi_02');

END;


BEGIN
    DBMS_SCHEDULER.DROP_JOB('atualiza_familias');
    DBMS_SCHEDULER.CREATE_JOB (
        job_name           =>  'atualiza_familias',
        job_type           =>  'STORED_PROCEDURE',
        job_action         =>  'PACK_BI_OFF.ATUALIZA_FAMILIAS',
        start_date         =>  SYSTIMESTAMP,
        end_date           =>  SYSTIMESTAMP+3,
        repeat_interval    =>  'FREQ=WEEKLY; BYDAY=SUN; BYHOUR=10; BYMINUTE=0; BYSECOND=0');

    DBMS_SCHEDULER.ENABLE('atualiza_familias');

END;
