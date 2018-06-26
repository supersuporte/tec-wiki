
DECLARE

  --ct_record countries%ROWTYPE;

  TYPE ct_record_type IS RECORD
  (countries_id   countries.country_id%TYPE,
   countries_name countries.country_name%TYPE,
   region_id      countries.region_id%TYPE);
  ct_record ct_record_type;

BEGIN
  SELECT *
  INTO ct_record
  FROM countries
  WHERE country_id = '&countryid';
  
  dbms_output.put_line('Country ID: ' || ct_record.countries_id || ' Name: ' || ct_record.countries_name || ' Region: ' || ct_record.region_id );
END;
/