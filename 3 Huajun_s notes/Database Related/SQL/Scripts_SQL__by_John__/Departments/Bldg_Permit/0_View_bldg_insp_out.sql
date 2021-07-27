set linesize 2000;
set pagesize 200;

--	====================================================

--	drop table	jdeacutis.EXTERNAL_VIEW;
	create table	jdeacutis.EXTERNAL_VIEW
(
	 item01		varchar(300)
--	,item02		varchar(100)
--	,item03		varchar(100)
--	,item04		varchar(100)
--	,item05		varchar(100)
)
	organization external
(
	type oracle_loader
	default directory	EXT_TABLES
	access parameters
(
	records delimited by newline
	fields terminated by ","
)
	location ('bldginsp_2000.txt')
)
	reject limit 100;

