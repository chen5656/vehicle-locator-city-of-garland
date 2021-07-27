--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	=====================================================================

	select lpad(line,6) ||'  '|| text   " "
	from	all_source 
	where upper(name)	= 'SCRUB_ADDRESSES' 
	and upper(owner)	= 'GARLAND' 
	and upper(type)	= 'PACKAGE'
	Order by line;


	select lpad(line,6) ||'  '|| text   " "
	from	all_source 
	where upper(name)	= 'SCRUB_ADDRESSES' 
	and upper(owner)	= 'GARLAND' 
	and upper(type)	= 'PACKAGE BODY'
	Order by line;

--	=====================================================================
