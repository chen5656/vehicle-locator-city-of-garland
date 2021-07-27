	select 'UTSTOPOND  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSTOPOND;

	explain plan set statement_id = 'UTSTOPOND'  into garland.plan_table  for

	Create table	UTSTOPOND
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	pond_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	pond_num			number(8,0),

	parent_id			varchar2(12),
	dcad_id			varchar2(17),

	latitude			number,
	longitude			number,

	access_instruction	varchar2(40),		--

	pond_size			number,
	pond_type			varchar2(10),

	inspect_date		varchar2(10),

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	pond_cond			varchar2(40),		-- 
	general_comments		varchar2(40)

)
	nologging
	tablespace			gis_data
	pctfree	20
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
