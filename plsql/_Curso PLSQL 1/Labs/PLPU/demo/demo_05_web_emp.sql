CREATE OR REPLACE PROCEDURE web_emp IS
BEGIN
  htp.htmlOpen;
  htp.headOpen;
  htp.title('Employees');
  htp.headClose;
  htp.bodyOpen;
  htp.print('<h1>Employees in Department 50</h1>');
  htp.print('<table border="1">');
  for rec in (select * from employees where department_id = 50)
  loop
    htp.print('<TR>');
    htp.print('<TD>'|| rec.employee_id ||'</TD>');
    htp.print('<TD>'|| rec.last_name ||'</TD>');
    htp.print('<TD>'|| rec.salary ||'</TD>');
    htp.print('</TR>');
  end loop;
  htp.print('</table>');
  htp.bodyClose;
  htp.htmlClose;
END;
/
