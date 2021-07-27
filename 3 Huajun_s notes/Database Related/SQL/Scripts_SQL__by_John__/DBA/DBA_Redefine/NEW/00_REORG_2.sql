
	set echo	off;
	set timing	on;

--	CREATE NEW TABLE COPIES

--	=====================================================================================================

	@c:\deacutis\scripts\ora_create\03_TABLES.sql;		--	create new table copies

--	=====================================================================================================

	set echo off;

	select count(*) "original"	from tmp_view	where tablespace_ = '=table=';

	select count(*) "new copy"	from dba_tables	where table_name like 'NEW_%';

	select key_		"Missing"
	from 	tmp_view
	where tablespace_ = '=table='
	and	not exists
	(
		select	table_name
		from		dba_tables
		where	table_name = name_append || key_ 
	);


--	===================================================================================================

	set echo 	on;
	set timing 	off;

