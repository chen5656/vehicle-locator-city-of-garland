	select 'UTWATPIPE  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTWATPIPE;

	explain plan set statement_id = 'UTWATPIPE'  into garland.plan_table  for

	Create table	UTWATPIPE
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	pipe_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	pipe_num			number(8,0),

	parent_id			varchar2(12),
	pipe_diameter		number,
	pipe_length			number,
	pipe_material		varchar2(04),

	pressure_normal		number,

	zone				varchar2(04),
	manufacturer		varchar2(20),

	work_order_num		varchar2(10),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	40
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

