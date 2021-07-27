	select 'UTWATHYDR  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTWATHYDR;	

	explain plan set statement_id = 'UTWATHYDR'  into garland.plan_table  for

	Create table	UTWATHYDR		
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	hydrant_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	hydrant_num			number(8,0),

	parent_id			varchar2(12),
	pressure_static		number,
	pressure_residual		number,
	pressure_flow_test	number,
	pressure_test_date	varchar2(10),

	hydrant_status		varchar2(15),
	hydrant_owner		varchar2(10),

	zone				varchar2(04),
	manufacturer		varchar2(20),

	work_order_num		varchar2(10),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	10
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

