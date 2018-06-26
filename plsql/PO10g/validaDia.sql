CREATE OR REPLACE FUNCTION validaDia(v_data DATE) RETURN VARCHAR2 AS
  v_dia CHAR(1) := TO_CHAR(v_data,'d');
BEGIN
  IF v_dia in (1,7) THEN
     RETURN 'Fim de Semana';
  ELSE
     RETURN 'Dia útil';
  END IF;

END;
/