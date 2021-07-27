	select 'UTWATTANK  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTWATTANK;

	explain plan set statement_id = 'UTWATTANK'  into garland.plan_table  for

	Create table	UTWATTANK			
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	tank_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	tank_num			number(8,0),

	parent_id			varchar2(12),
	tank_diameter		number,
	tank_height			number,
	tank_type			varchar2(02),
	tank_material		varchar2(10),
	tank_status			varchar2(15),

	capacity			number,
	overflow_elev		number,
	alarm_level_high		number,
	alarm_level_low		number,

	zone				varchar2(04),

	work_order_num		varchar2(10),	
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	30
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

