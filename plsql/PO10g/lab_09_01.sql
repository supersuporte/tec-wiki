CREATE OR REPLACE PROCEDURE ADD_JOB(v_id JOBS.JOB_ID%TYPE, v_job_title JOBS.JOB_TITLE%TYPE) AS
BEGIN  
  INSERT INTO JOBS (JOB_ID,JOB_TITLE)
  VALUES (v_id,v_job_title);
  COMMIT;
  dbms_output.put_line('Registro inserido com sucesso!');

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Não é possível gravar. Erro fatal. Consulte o Administrador do Sistema.');

END;
/