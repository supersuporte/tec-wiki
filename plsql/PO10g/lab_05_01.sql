DECLARE
  cont integer := 10;
BEGIN
  FOR I IN 1..cont LOOP
  IF I <> 6 AND I <> 8 THEN
    INSERT INTO MESSAGES
    VALUES (I);
    COMMIT;
  END IF;
  END LOOP;
END;
/