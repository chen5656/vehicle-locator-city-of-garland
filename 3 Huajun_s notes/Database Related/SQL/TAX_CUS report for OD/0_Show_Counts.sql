--	============================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	define		off;
set	linesize		1000;
set	pagesize		50000;
--	sqldeveloper: TOOLS > PREFERENCES > WORKSHEET > max rows to print
--	============================================================
--	execute jdeacutis.show_source	('xxx','garland','');
--	execute jdeacutis.show_error	('xxx','garland','');
--	execute jdeacutis.show_table_column	('', 'garland jdeacutis', ' ');
--	execute jdeacutis.show_index_column	(' ', ' ', ' ');
--	execute jdeacutis.show_view		(' ', ' ', ' ');
--	alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';  
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	============================================================

	select count(*) tax_cus	from jdeacutis.Temp_View where taxid > '0' and umsid > '0';
	select count(*) tax	from jdeacutis.Temp_View where taxid > '0' and nvl(umsid,'0') = '0';
	select count(*) cus	from jdeacutis.Temp_View where umsid > '0' and nvl(taxid,'0') = '0';

	select count(*) taxpar	from garland.adrResult_TAX_GDS where verify_code = 45 and segment_id > '0';
	select count(*) cuspar	from garland.adrResult_BANNER  where verify_code = 45 and segment_id > '0';
	select owner, object_name, to_char(last_ddl_time, 'mon dd yyyy hh24:mi') from all_objects 
		where object_name in ('ADRRESULT_TAX_GDS', 'ADRRESULT_BANNER' );

--	=====================================================================	
/*

	select
		rpad(seq		,05)		seq,
		rpad(parcelid		,15)		parcelid,
		rpad(addr_num		,10)		num,
		rpad(addr_pfx		,05)		pfx,
		rpad(addr_name		,20)		name,
		rpad(addr_type		,05)		type,
		rpad(addr_sfx		,05)		sfx,
		rpad(dcad		,20)		dcad,
		rpad(tenant		,40)		tenant,
		rpad(gisid		,10)		gisid,
		rpad(taxid		,10)		taxid,
		rpad(umsid		,10)		umsid
	from	jdeacutis.Temp_View
	where	rownum < 111
	and	taxid	is null  and umsid > 0
	;

*/