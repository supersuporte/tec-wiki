BEGIN
  dbms_warning.set_warning_setting_string('ENABLE:ALL','session');
  dbms_warning.add_warning_setting_cat('PERFORMANCE','disable','session');
END;
/
