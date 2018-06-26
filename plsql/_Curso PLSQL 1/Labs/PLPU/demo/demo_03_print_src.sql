set serveroutput on
-- Use this to show how you can quickly use the data dictionary
-- to create source code to be included in a package body
-- converting stand-alone procedures to packaged ones.
--
declare
  procedure print(s varchar2) is
  begin
    dbms_output.put_line(s);
  end;
  procedure get_src(proc_name varchar2) is
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
  get_src('ADD_JOB');
  get_src('DEL_JOB');
  get_src('GET_JOB');
  get_src('UPD_JOB');
end;
/
