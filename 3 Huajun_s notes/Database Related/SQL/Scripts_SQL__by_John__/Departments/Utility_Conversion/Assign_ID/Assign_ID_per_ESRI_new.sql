	set echo	off;
--	========================================================================
--	Assign "feature" id to a specified utility table

--	PREPARE specifications indicated by "CHANGE"

--	BACKUP EXPORT OF TABLE TO BE UPDATED	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--	========================================================================

--	PUT THIS INTO A VIEW		<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	variable	 last_num	number;
	execute	:last_num := 4000;				

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

			'WT',	'VA'						

	from		garland.GIS_Objects;

--	========================================================================

	create or replace view	garland.Temp_View1
(
		utility_id,
		utility_num,

		mslink,
		mapid,
		grid,
		quad,

		prefix,
		suffix
)
	as
	select	VALVE_id,
			VALVE_num,
			mslink,	mapid,	map_grid,	map_quad,

			'WT',	'VA'							--  CHANGE

	from		garland.UTWATVALV;					--  CHANGE

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	garland.Temp_View1		U			

	set	(	utility_id,	utility_num,	 			
			mapid, grid, quad	)  
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

	select	u.grid, u.quad, 

			utility_num,	'        ' " ",	utility_id		

	from		garland.Temp_View1	U,				

			garland.Temp_View		T

	where		t.mslink = rtrim(u.mslink)

	and		utility_num > 4000					

	and		rownum < 111
	;

--	-----------------------------------------------------------------------------
--	how many records in table
--	how many complete records exist

	select count(*) "TOTAL"  from garland.Temp_View1;	

	select count(*)  "COMPLETED"
	from	 garland.Temp_View1					
	where	 length(utility_id) > 8					
	and	 utility_num 		> :last_num				
	and	 mapid  is not null
	and	 grid > '0'
	and	 quad > '0'; 

--	-----------------------------------------------------------------------------
--	what is maximum _NUM

	select max(substr(utility_id, instr(utility_id, '-') + 01  ))  "max NUM"
	from	garland.Temp_View1						
	where length(utility_id) >= 12 
	;

--	-----------------------------------------------------------------------------
--	is _NUM unique

	select sum(count(*))  "DUPE NUMs",
		 max(utility_NUM) "MAX  NUM"	

	from	garland.Temp_View1						
	group by	utility_num						
	having	count(*) > 1;

--	-----------------------------------------------------------------------------
--	is ID truncated

	select mslink, utility_id
	from	garland.Temp_View1						
	where	utility_id not like '%VA';				

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	;			-- insure termination of last command
	ROLLBACK;

	commit;
	alter rollback segment rb1 offline;

--	========================================================================
	set echo	on;
