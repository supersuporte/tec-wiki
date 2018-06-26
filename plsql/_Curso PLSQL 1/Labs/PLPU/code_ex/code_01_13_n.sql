VARIABLE phone_no VARCHAR2(15)
EXECUTE :phone_no := '8006330575' 
PRINT phone_no
EXECUTE format_phone (:phone_no)
PRINT phone_no
