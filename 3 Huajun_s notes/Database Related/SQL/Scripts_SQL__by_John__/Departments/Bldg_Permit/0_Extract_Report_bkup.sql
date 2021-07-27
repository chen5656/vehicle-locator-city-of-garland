--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================

	truncate table garland.gis_objects reuse storage;

	insert into garland.gis_objects (item01, item02)
	select lpad(rownum,5,'0'), E.* 
	from	jdeacutis.EXTERNAL_VIEW1 E;
	
	select lpad(item01,5), item02 from garland.gis_objects order by item01;

--	=====================================================================