SET SERVEROUTPUT ON;
BEGIN
  UPDATE orders SET order_status = order_status;
  FOR v_rec IN (SELECT order_id FROM orders) LOOP
    IF SQL%ISOPEN THEN
       DBMS_OUTPUT.PUT_LINE('TRUE - ' || SQL%ROWCOUNT);
    ELSE
       DBMS_OUTPUT.PUT_LINE('FALSE - ' || SQL%ROWCOUNT);
    END IF;
  END LOOP;
END;
/
