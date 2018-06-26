DECLARE
  CURSOR cur_update IS
    SELECT * FROM customers
    WHERE cust_credit_limit < 5000 FOR UPDATE;
BEGIN
  FOR v_rec IN cur_update
  LOOP
    IF v_rec.cust_credit_limit IS NOT NULL
    THEN
      UPDATE customers
      SET cust_credit_limit = cust_credit_limit + 200
      WHERE CURRENT OF cur_update;
    END IF;
  END LOOP;
END;
/
