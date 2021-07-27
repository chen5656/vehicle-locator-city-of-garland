--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	drop table		jdeacutis.WATER_PARCEL_PIPE_EXTERNAL;
	create table	jdeacutis.WATER_PARCEL_PIPE_EXTERNAL
(
	PIPE_ID		varchar2(100),   
	PARCEL_ID		varchar2(100)		
)
	organization external
(
	type oracle_loader
	default directory	EXT_TABLES
	access parameters
(
	records delimited by newline
	fields terminated by ','
	optionally enclosed by '"'
)
	location ('WATER_PARCEL_PIPE.txt')
)
	reject limit 999;

--	====================================================