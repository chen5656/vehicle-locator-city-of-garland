	select 'UTSTOJUNC  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSTOJUNC;

	explain plan set statement_id = 'UTSTOJUNC'  into garland.plan_table  for

	Create table	UTSTOJUNC
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	junction_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	junction_num		number(8,0),

	parent_id			varchar2(12),
	junction_diameter		number,
	junction_type		varchar2(02),
	junction_material		varchar2(05),

	upstr_node_elev		number,
	dnstr_node_elev		number,
	upstr_hyd_grade		number,
	dnstr_hyd_grade		number,

	inspect_date		varchar2(10),		--

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	junction_cond		varchar2(40),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	20
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
