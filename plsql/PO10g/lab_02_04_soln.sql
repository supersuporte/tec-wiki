set autoprint on;

variable basic_percent number;
variable pf_percent number;

declare
  today date := sysdate;
  tomorrow today%TYPE := sysdate+1;
begin
  :basic_percent := 45;
  :pf_percent := 12;
  dbms_output.put_line(today);
  dbms_output.put_line(tomorrow);
end;
/