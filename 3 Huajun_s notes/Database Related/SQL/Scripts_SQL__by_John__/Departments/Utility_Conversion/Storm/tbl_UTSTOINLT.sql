	select 'UTSTOINLT  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSTOINLT;

	explain plan set statement_id = 'UTSTOINLT'  into garland.plan_table  for

	Create table	UTSTOINLT
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	inlet_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	inlet_num			number(8,0),

	parent_id			varchar2(12),
	inlet_size			number,
	inlet_type			varchar2(20),
	inlet_code			varchar2(02),
	epa_tag			varchar2(10),

	inspect_date		varchar2(10),		-- 

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	inlet_cond			varchar2(40),		-- 
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	20
	storage			(initial 50k  next 50k  pctincrease 0);

--	===============================================================
