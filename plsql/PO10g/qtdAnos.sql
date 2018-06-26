CREATE OR REPLACE FUNCTION qtdAnos(dataInicial DATE, dataFinal DATE) RETURN NUMBER AS
  anos NUMBER;
BEGIN
  anos := TRUNC(MONTHS_BETWEEN(dataInicial, dataFinal)/12);
  IF anos < 0 THEN
    anos := anos * (-1);
  END IF;
  RETURN anos;

END;
/