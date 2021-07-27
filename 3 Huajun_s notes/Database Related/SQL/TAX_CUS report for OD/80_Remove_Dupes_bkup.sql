--	=====================================================================
	select * from viewer.me;
--	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

	select
		rpad(addr_num	,20),
		rpad(addr_pfx	,20),
		rpad(addr_name	,20),
		rpad(addr_type	,20),
		rpad(addr_sfx	,20),
		rpad(tenant		,20),
		rpad(dcad		,20)

	from	jdeacutis.Temp_View
	where (addr_num, addr_pfx, addr_name, addr_type, addr_sfx )		IN
(
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	jdeacutis.Temp_View
	group by  addr_pfx, addr_name, addr_type, addr_sfx,addr_num
	having count(*) > 1
);

--	=====================================================================

	delete from jdeacutis.Temp_View
	where	dcad is null
	and (addr_num, addr_pfx, addr_name, addr_type, addr_sfx )		IN
(
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	jdeacutis.Temp_View
	group by  addr_pfx, addr_name, addr_type, addr_sfx,addr_num
	having count(*) > 1
);

	COMMIT;

--	=====================================================================
