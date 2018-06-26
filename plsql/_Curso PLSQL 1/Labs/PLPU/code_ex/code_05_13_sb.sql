SET SERVEROUTPUT ON
BEGIN
  htp.htmlOpen;
  htp.headOpen;
  htp.title('Welcome');
  htp.headClose;
  htp.bodyOpen;
  htp.print('My home page');
  htp.bodyClose;
  htp.htmlClose;
END;
/
EXECUTE OWA_UTIL.SHOWPAGE
