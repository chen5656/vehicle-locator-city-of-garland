	set echo	off;
--	========================================================================
--	Assign "feature" id to a specified utility table

--	PREPARE specifications indicated by "CHANGE"

--	BACKUP EXPORT OF TABLE TO BE UPDATED	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--	========================================================================

	variable	 last_num	number;
	execute	:last_num := 4000;				--  CHANGE

--	========================================================================

	create or replace view	garland.Temp_View
(
		mslink,
		mapid,
		grid,
		quad,

		prefix,
		suffix
)
	as
	select	item01, item02, item03, item04,

			'WT',	'VA'						--  CHANGE

	from		garland.GIS_Objects;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	garland.UTWATVALV		U			--  CHANGE

	set	(	VALVE_id,	VALVE_num,	 			--  CHANGE
			mapid, map_grid, map_quad	)  
	=
(
	select	t.prefix || t.grid || t.quad || '-' || (:last_num + v.row_num) || t.suffix,
			:last_num + v.row_num, 
			v.mapid, v.grid, v.quad			

	from		garland.Temp_View		T,

(	select	mslink, mapid, grid, quad,
			rownum	row_num 
			from Temp_View	)	V

	where		t.mslink	= rtrim(u.mslink)
	and		t.mslink	= v.mslink

)

	where exists
(
	select 'x'
	from	 garland.Temp_View
	where	 mslink = rtrim(u.mslink)
)


--	and  rownum < 111			--  T E S T   R U N
	;


--	===========================================================================
--	VERIFY UNIQUE MSLINK on INPUT

	select distinct 
	rpad(mslink,10)	mslink,
	rpad(mapid, 10)	mapid,
	rpad(grid,  10)   grid,	
	rpad(quad,  10)	quad

	from	garland.temp_view

	where	mslink in
(
	select mslink
	from temp_view
	group by mslink
	having count(*) > 1
)
	order by mslink
	;

--	===========================================================================
--	VERIFY SAMPLE

	select	map_grid, map_quad, 

			VALVE_num,	'        ' " ",	VALVE_id		--  CHANGE

	from		garland.UTWATVALV		U,				--  CHANGE

			garland.Temp_View		T

	where		t.mslink = rtrim(u.mslink)

	and		VALVE_num > 4000					--  CHANGE

	and		rownum < 111
	;

--	-----------------------------------------------------------------------------
--	how many records in table
--	how many complete records exist

	select count(*) "TOTAL"  from garland.UTWATVALV;	--  CHANGE

	select count(*)  "COMPLETED"
	from	 garland.UTWATVALV					--  CHANGE
	where	 length(VALVE_id) > 8					--  CHANGE
	and	 VALVE_num 		> :last_num				--  CHANGE
	and	 mapid  is not null
	and	 map_grid > '0'
	and	 map_quad > '0'; 

--	-----------------------------------------------------------------------------
--	what is maximum _NUM

	select max(substr(valve_id, instr(valve_id, '-') + 01  ))  "max NUM"
	from	garland.UTWATVALV						--  CHANGE
	where length(valve_id) >= 12 
	;

--	-----------------------------------------------------------------------------
--	is _NUM unique

	select sum(count(*))  "DUPE NUMs",
		 max(VALVE_NUM) "MAX  NUM"	

	from	garland.UTWATVALV						--  CHANGE
	group by	VALVE_num						--  CHANGE
	having	count(*) > 1;

--	-----------------------------------------------------------------------------
--	is ID truncated

	select mslink, valve_id
	from	garland.UTWATVALV						--  CHANGE
	where	VALVE_id not like '%VA';				--  CHANGE

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	;			-- insure termination of last command
--	ROLLBACK;

	commit;
	alter rollback segment rb1 offline;

--	========================================================================
	set echo	on;
