SELECT trigger_name, trigger_type, triggering_event,
	table_name, referencing_names,
	status, trigger_body
FROM   user_triggers
WHERE  trigger_name = 'RESTRICT_SALARY';
