	select 'UTWATFITT  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTWATFITT;	

explain plan set statement_id = 'UTWATFITT'  into garland.plan_table  for

	Create table	UTWATFITT
(
	mslink				number(8,0)		not null,
	mapid					number(8,0),
	project_num				varchar2(11),
	scan_num				varchar2(20),

	fitting_id				varchar2(12),
	map_grid				varchar2(03),
	map_quad				varchar2(1),
	fitting_num				number(8,0),

	parent_id				varchar2(12),
	fitting_size			number,
	fitting_type			varchar2(10),

	pressure_normal			number,
	pressure_source			varchar2(10),

	zone					varchar2(04),
	manufacturer			varchar2(20),

	work_order_num			varchar2(10),
	general_comments			varchar2(40)
)
	nologging
	pctfree	40
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

