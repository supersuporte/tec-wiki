CREATE TABLE log_trig_table(
  user_id  VARCHAR2(30),
  log_date DATE,
   action  VARCHAR2(40))
/

CREATE OR REPLACE TRIGGER logon_trig
AFTER LOGON  ON  SCHEMA
BEGIN
 INSERT INTO log_trig_table(user_id,log_date,action)
 VALUES (USER, SYSDATE, 'Logging on');
END;
/
