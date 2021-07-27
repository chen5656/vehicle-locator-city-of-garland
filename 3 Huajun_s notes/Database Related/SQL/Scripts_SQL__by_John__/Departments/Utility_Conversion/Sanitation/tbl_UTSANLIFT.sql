	select 'UTSANLIFT  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSANLIFT;

	explain plan set statement_id = 'UTSANLIFT'  into garland.plan_table  for

	Create table	UTSANLIFT	
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	liftsta_id			varchar2(12),		
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	liftsta_num			number(8,0),		

	parent_id			varchar2(12),
	liftsta_desc		varchar2(25),
	liftsta_size		number,			
	liftsta_status		varchar2(15),	
	liftsta_name		varchar2(20),	

	upstr_node			varchar2(12),
	dnstr_node			varchar2(12),

	upstr_manhole_node	varchar2(12),		
	dnstr_manhole_node	varchar2(12),

	pump_type			varchar2(12),
	pump_cap			number,
	wet_well_cap		number,
	standby_gen			varchar2(01),

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
