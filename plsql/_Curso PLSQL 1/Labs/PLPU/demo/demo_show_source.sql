accept proc prompt "Object name: "
accept type prompt "Object type: "
accept startl prompt "Start line: "
accept endl prompt "End line: "
select text
from user_source
where name = UPPER('&proc') and type = UPPER('&type')
and line between &startl and &endl
/
undef proc startl endl
