	select 'UTWATVALV  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTWATVALV;	

	explain plan set statement_id = 'UTWATVALV'  into garland.plan_table  for

	Create table	UTWATVALV
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	valve_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	valve_num			number(8,0),

	parent_id			varchar2(12),
	valve_size			number,
	valve_type			varchar2(10),

	pressure_normal		number,
	valve_status		varchar2(06),

	zone				varchar2(04),
	manufacturer		varchar2(20),

	work_order_num		varchar2(10),	
	general_comments		varchar2(40)
)
	nologging
	pctfree	40
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

