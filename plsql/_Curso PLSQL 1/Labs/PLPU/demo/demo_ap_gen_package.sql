set serveroutput on size 1000000
declare
  procedure print(s varchar2) is
  begin
    dbms_output.put_line(s);
  end;
  procedure gen_spec(proc_name varchar2) is
    cursor src  is 
      select text from user_source
      where name = proc_name
      and line = 1;
  begin
   for rec in src
   loop
    print(rec.text);
   end loop;
  end;
  procedure gen_body(proc_name varchar2) is
    cursor src  is 
      select text from user_source
      where name = proc_name order by line;
  begin
   for rec in src
   loop
    print(rec.text);
   end loop;
  print(chr(10)||'--');
  end;
begin

  print('CREATE OR REPLACE PACKAGE empjob_pkg IS');
  gen_spec('ADD_JOB_HIST');
  gen_spec('GET_JOB_COUNT');
  gen_spec('GET_YEARS_SERVICE');
  gen_spec('NEW_JOB');
  gen_spec('UPD_JOBSAL');
  print('END empjob_pkg;');
  print('/');
  print('SHOW ERRORS');
  print('CREATE OR REPLACE PACKAGE BODY empjob_pkg IS');
  gen_body('ADD_JOB_HIST');
  gen_body('GET_JOB_COUNT');
  gen_body('GET_YEARS_SERVICE');
  gen_body('NEW_JOB');
  gen_body('UPD_JOBSAL');
  print('END empjob_pkg;');
  print('/');
  print('SHOW ERRORS');
end;
/
