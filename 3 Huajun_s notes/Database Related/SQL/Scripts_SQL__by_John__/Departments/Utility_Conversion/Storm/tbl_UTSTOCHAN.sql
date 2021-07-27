
	select 'UTSTOCHAN  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSTOCHAN;

	explain plan set statement_id = 'UTSTOCHAN'  into garland.plan_table  for

	Create table	UTSTOCHAN
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	channel_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	channel_num			number(8,0),

	parent_id			varchar2(12),
	channel_desc		varchar2(25),		
	channel_length		number,
	channel_size		number,
	channel_type		varchar2(05),

	inspect_date		varchar2(10),
	clean_date			varchar2(10),
	maint_resp			varchar2(10),

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	channel_cond		varchar2(40),		--
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	20
	storage			(initial 50k  next 50k  pctincrease 0);

--	===============================================================
