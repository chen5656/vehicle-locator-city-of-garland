	select 'UTWATMETR  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTWATMETR;

	explain plan set statement_id = 'UTWATMETR'  into garland.plan_table  for

	Create table	UTWATMETR
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	meter_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	meter_num			number(8,0),

	parent_id			varchar2(12),
	meter_size			number,
	meter_type			varchar2(20),

	zone				varchar2(04),
	manufacturer		varchar2(20),
	serial_num			number,			

	billing_class		varchar2(12),
	account_num			varchar2(10),

	work_order_num		varchar2(10),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	60
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================

