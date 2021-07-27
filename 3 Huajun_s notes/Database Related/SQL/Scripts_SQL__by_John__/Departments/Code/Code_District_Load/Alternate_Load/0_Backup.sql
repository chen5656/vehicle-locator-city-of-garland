--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	drop table jdeacutis.code_district_bkup;

	create table jdeacutis.code_district_bkup  
	nologging 
	tablespace gis_data
	as select * from garland.code_district;