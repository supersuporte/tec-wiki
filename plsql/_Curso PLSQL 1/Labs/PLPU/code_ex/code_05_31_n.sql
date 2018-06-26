SELECT job_name, program_name, job_type, state
FROM USER_SCHEDULER_JOBS;

SELECT job_name, instance_id, req_start_date, actual_start_date, status FROM ALL_SCHEDULER_JOB_RUN_DETAILS;


SELECT job_name, status, error#, run_duration, cpu_used
FROM USER_SCHEDULER_JOB_RUN_DETAILS;

REM Only as SYSTEM/SYS or a user with access to the DBA data dictionary
REM you can execute the following:
--
-- SELECT owner, job_name, running_instance, resource_consumer_group
-- FROM DBA_SCHEDULER_RUNNING_JOBS;
