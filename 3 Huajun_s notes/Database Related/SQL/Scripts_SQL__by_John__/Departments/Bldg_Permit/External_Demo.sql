--	====================================================

	drop table	jdeacutis.EXTERNAL_VIEW1;
	create table	jdeacutis.EXTERNAL_VIEW1
(
	 item01		varchar(1000)
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

	fields terminated by "|"				==
	fields terminated by whitespace			==
)
	location ('BLDG_INSP_2006_DEMO.txt')
)
	reject limit 100;

