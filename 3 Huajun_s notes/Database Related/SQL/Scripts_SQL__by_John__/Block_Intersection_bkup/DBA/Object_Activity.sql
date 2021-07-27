	set echo	off;
--	===========================================================================================
--	Look at DDL activity on objects of specific types for specific time intervals
--	===========================================================================================

--	desc obj;

--	===========================================================================================

	select rpad(object_name,25) "name",  object_type, created, last_ddl_time, timestamp
	from obj

	where rownum < 111

--	and	object_type in ( 'TABLE', 'INDEX'  )
--	and	object_type in ( 'VIEW'  )
	and	object_type in ( 'TRIGGER'  )
--	and	object_type in ( 'PACKAGE', 'PACKAGE_BODY', 'PROCEDURE', 'FUNCTION'  )

	and	timestamp like '2003%'

	order by object_type, object_name;

--	===========================================================================================
	set echo	on;

