	select 'UTWATPUMP  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTWATPUMP;

	explain plan set statement_id = 'UTWATPUMP'  into garland.plan_table  for

	Create table	UTWATPUMP
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	pumpsta_id			varchar2(12),	
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	pumpsta_num			number(8,0),	

	parent_id			varchar2(12),
	pumpsta_type		varchar2(10),	
	pump_type			varchar2(10),

	quantity			number,
	capacity			number,
	standby_gen			varchar2(01),

	zone				varchar2(04),
	address			varchar2(40),

	work_order_num		varchar2(10),	
	general_comments		varchar2(40)
)
	nologging
	pctfree	20
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

