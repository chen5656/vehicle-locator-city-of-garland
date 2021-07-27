--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';

--	================================================================
	drop table		jdeacutis.EXTERNAL_VIEW1;
	create table	jdeacutis.EXTERNAL_VIEW1
(
  text         varchar2(100)   
)
	organization external
(
	type oracle_loader
	default directory	EXT_TABLES
	access parameters
(
	records delimited by newline
	fields terminated by '|'
	optionally enclosed by '"'
)
	location ('WATER_PIPE_COORDS.txt')
)
	reject limit 999;

--	====================================================