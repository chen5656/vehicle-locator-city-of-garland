	select 'UTSANPLUG  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	fitting code = 'PL'

--	drop table		UTSANPLUG;

	explain plan set statement_id = 'UTSANPLUG'  into garland.plan_table  for

	Create table	UTSANPLUG
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	plug_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	plug_num			number(8,0),

	parent_id			varchar2(12),
	plug_size			number,

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

