--	execute scripts with large amounts of inserts or updates

--	PREPARATION
--		insure extract matches desc  (new fields may have be involved)
--		obtain count of records to be extracted from cdep.world
--		set extract counts 	in \\extract_code_inspect.sql
--		set date range 		in \\extract_code_inspect.sql

--	---------------------------------------------------------------------------------
--	obtain count of records to be extracted

	select	count(*)
--+  	all_rows	driving_site (i)	
	from	 inspection@cdep.world		i
		,codeaddr@cdep.world		a
		,case_violation@cdep.world	v
	where to_char (i.inspection_date, 'yyyy') = '2001'
--	or	i.inspection_date			between '01JAN01' and '31DEC01' )
	and	i.addr_id	  	= a.addr_id
	and	i.case_number 	= v.case_number;

--	---------------------------------------------------------------------------------

	alter rollback segment rb_large	online;
	set transaction use rollback segment rb_large;

--	---------------------------------------------------------------------------------
--	build NSA_CODE_INSPECT extract

--	drop synonym	syn_gis_table;
--	create synonym	syn_gis_table		for GARLAND.NSA_CODE_INSPECT;

	truncate table	GARLAND.NSA_CODE_INSPECT	reuse storage;

	@c:\deacutis\scripts\nsa\code\extract_code_inspect.sql;

	analyze table	GARLAND.NSA_CODE_INSPECT	compute statistics;

--	select * from syn_gis_table	where rownum < 22;
	select count(*) from syn_gis_table;
	select * from dba_segments where segment_name = 'NSA_CODE_INSPECT' and owner = 'GARLAND';

--	---------------------------------------------------------------------------------

	commit;
	alter rollback segment rb_large	offline;

--	---------------------------------------------------------------------------------

	@c:\deacutis\scripts\nsa\code\complete_code_inspect.sql;

--	---------------------------------------------------------------------------------
