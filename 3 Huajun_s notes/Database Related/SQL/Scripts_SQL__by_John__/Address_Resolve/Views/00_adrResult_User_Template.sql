--	===============================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	===============================================================
--	adrResult_User = 
--	===============================================================

	create or replace	view	garland.adrResult_User		AS
	select
				rec_key,
		null		rec_rowid,	

				addr_num,
				addr_pfx,
				addr_name,
				addr_type,
				addr_sfx,

				addr_code1,
				addr_unit1,
				addr_code2, 
				addr_unit2
	from	
	;

--	===============================================================
