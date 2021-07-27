--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	================================================================

	create or replace view		garland.Temp_View1
	(
		account,
		attn,
		name,
		unit,
		strt,
		city,
		state,
		cast,
		error
	)
	as select	item01, item02, item03, item04, item05, item06, item07, item08, item09
	from		garland.GIS_Temp1; 


