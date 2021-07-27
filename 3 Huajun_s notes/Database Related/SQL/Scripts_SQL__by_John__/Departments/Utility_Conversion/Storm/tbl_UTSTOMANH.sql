
	select 'UTSTOMANH  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

	drop table		UTSTOMANH;

--	explain plan set statement_id = 'UTSTOMANH'  into garland.plan_table  for


	Create table	UTSTOMANH
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	manhole_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	manhole_num			number(8,0),

	parent_id			varchar2(12),
	latitude			number,
	longitude			number,

	inspect_date		varchar2(10),

	CONSTRUCT_DATE 		VARCHAR2(10),			--  mar 2004

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	manhole_cond		varchar2(40),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	40
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
