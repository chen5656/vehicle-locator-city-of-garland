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

	select count(*) from jdeacutis.Temp_View;

	select seq, count(*) from jdeacutis.Temp_View group by seq having count(*) > 1;

--	=====================================================================	

	select 'seq;parcelid;num;pfx;name;type;sfx;dcad;tenant;gisid;taxid;umsid'  from dual
	UNION ALL

	select * from
(
	select
		seq			||';'||
		parcelid		||';'||

		addr_num		||';'||
		addr_pfx		||';'||
		addr_name		||';'||
		addr_type		||';'||
		addr_sfx		||';'||

		dcad			||';'||
		tenant		||';'||

		gisid			||';'||
		taxid			||';'||
		umsid
	from	jdeacutis.Temp_View
	order by lpad(seq,6,'0')
)
;

