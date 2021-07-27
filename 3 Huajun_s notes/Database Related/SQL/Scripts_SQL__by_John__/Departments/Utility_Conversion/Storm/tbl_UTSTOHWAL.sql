	select 'UTSTOHWAL  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTSTOHWAL;

	explain plan set statement_id = 'UTSTOHWAL'  into garland.plan_table  for

	Create table	UTSTOHWAL
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	headwall_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	headwall_num		number(8,0),

	parent_id			varchar2(12),
	headwall_diameter		number,
	headwall_type		varchar2(01),
	boxtall			number,
	boxwide			number,
	quantity			number,

	inspect_date		varchar2(10),

	headwall_cond		varchar2(40),
	general_comments		varchar2(40)
)
	tablespace			gis_data
	nologging
	pctfree	40
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
