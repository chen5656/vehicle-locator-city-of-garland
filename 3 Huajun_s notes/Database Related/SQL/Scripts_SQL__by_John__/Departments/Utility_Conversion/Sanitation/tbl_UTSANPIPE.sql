
	select 'UTSANPIPE  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSANPIPE;

	explain plan set statement_id = 'UTSANPIPE'  into garland.plan_table  for

	Create table	UTSANPIPE
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
	pipe_type			varchar2(10),
	pipe_class			varchar2(10),		--
	pipe_material		varchar2(10),
	slope				number,

	upstr_node			varchar2(12),
	upstr_node_type		varchar2(02),
	upstr_basin			varchar2(05),
	upstr_sub_basin		varchar2(05),
	upstr_node_sub_basin	varchar2(05),
	upstr_node_elev		number,
	upstr_node_grnd_elev	number,

	dnstr_node			varchar2(12),
	dnstr_node_type		varchar2(02),
	dnstr_basin			varchar2(05),
	dnstr_sub_basin		varchar2(05),
	dnstr_node_sub_basin	varchar2(05),
	dnstr_node_elev		number,
	dnstr_node_grnd_elev	number,

	basin				varchar2(20),
	sub_basin			varchar2(20),
	sub_subbasin		varchar2(20),

	modeled			varchar2(01),
	idm				number,
	manufacturer		varchar2(15),

	general_comments		varchar2(40)
)
	nologging
	pctfree	20
	tablespace			gis_data
	storage			(initial 100K  next 100K  pctincrease 0);

--	===============================================================
