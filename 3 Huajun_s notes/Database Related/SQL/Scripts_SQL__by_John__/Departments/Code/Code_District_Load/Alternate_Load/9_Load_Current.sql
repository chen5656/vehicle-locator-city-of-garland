--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	truncate table  garland.code_district	reuse storage;

	insert --+ append
	into	garland.code_district
	select * from jdeacutis.code_district
	order by nuisance_district;

	Commit;
