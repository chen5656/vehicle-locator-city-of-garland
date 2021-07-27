	select 'UTSANMANH  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

	drop table		UTSANMANH;

--	explain plan set statement_id = 'UTSANMANH'  into garland.plan_table  for

	Create table	UTSANMANH
(
	mslink			number(8,0)	not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	manhole_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	manhole_num			number(8,0),

	parent_id			varchar2(12),
	gps_x				number,
	gps_y				number,

	manhole_size		number,			--
	upstr_manhole_node	varchar2(12),		--  
	dnstr_manhole_node	varchar2(12),		--  

	CONSTRUCT_DATE		 VARCHAR2(10),		--   mar 2004

	basin				varchar2(20),
	sub_basin			varchar2(20),
	sub_subbasin		varchar2(20),

	general_comments		varchar2(40)
)
	nologging
	pctfree	20
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
