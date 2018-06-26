DECLARE
  CURSOR cur_update 
  IS SELECT * FROM customers 
  WHERE credit_limit < 5000 FOR UPDATE;
BEGIN
  FOR v_rec IN cur_update
    LOOP
      IF v_rec IS NOT NULL THEN
	UPDATE customers 
	SET credit_limit = credit_limit + 200
	WHERE customer_id = v_rec.customer_id;
      END IF;
    END LOOP;
END;
/
