desc regions
create or replace trigger test1 
before insert or update on regions
for each row
begin
  IF updating THEN
    dbms_output.put_line('UPD OLD id: '||:old.region_id||' name: '||:old.region_name);
    dbms_output.put_line('UPD NEW id: '||:new.region_id||' name: '||:new.region_name);
  ELSE
    dbms_output.put_line('INS NEW id: '||:new.region_id||' name: '||:new.region_name);
  END IF;
end;
/
show errors
insert into regions values (10, 'Aust');
update regions set region_name = 'Australia' where region_id = 10;
rollback;
drop trigger test1;
---
--- Modified to fire only if the selected items values have really changed.
---
desc regions
create or replace trigger test1 
before insert or update on regions
for each row
when (new.region_name <> NVL(old.region_name, '?'))
begin
  DBMS_OUTPUT.PUT_LINE('Trigger fired');
  IF updating THEN
    dbms_output.put_line('UPD OLD id: '||:old.region_id||' name: '||:old.region_name);
    dbms_output.put_line('UPD NEW id: '||:new.region_id||' name: '||:new.region_name);
  ELSE
    dbms_output.put_line('INS NEW id: '||:new.region_id||' name: '||:new.region_name);
  END IF;
end;
/
show errors
insert into regions values (10, 'Aust');
update regions set region_name = 'Australia' where region_id = 10;
update regions set region_name = 'Australia' where region_id = 10;
rollback;
drop trigger test1;
