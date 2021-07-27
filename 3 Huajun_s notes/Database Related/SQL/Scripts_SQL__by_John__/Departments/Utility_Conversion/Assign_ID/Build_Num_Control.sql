
--	====================================================================================     

	truncate table	garland.plan_table			reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	====================================================================================     

	insert /*+ append */	into	garland.Utility_Num_Control
	select  tablename, grid, quad, max(num) num	from
( 
	select
		'UTWATPIPE'					tablename,
		rtrim(map_grid)				grid,
		map_quad					quad,
		rtrim(PIPE_NUM)				num
	from	garland.UTWATPIPE

	where	PIPE_NUM	>   0
	and	map_grid	>  '0'
	and	ltrim(map_grid,'0123456789ABCD') is null
	and	map_quad	between 'A' and 'D'

	UNION

	select
		'UTWATPIPE'										tablename,
		substr (PIPE_ID, 03,	instr(PIPE_ID, '-') - 4)			grid,
		substr (PIPE_ID,		instr(PIPE_ID, '-') - 1, 1) 			quad,
		substr (PIPE_ID,		instr(PIPE_ID, '-') + 1,
					length(PIPE_ID) - instr(PIPE_ID, '-') - 2)	num
	from	garland.UTWATPIPE

	where	translate (PIPE_ID,'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ','000000000AAAAAAAAAAAAAAAAAAAAAAAAAA') 
		like 'AA0%A%-0%AA'
	and	translate (PIPE_ID,'A`~!@#$%^&*()_=+\|[{]};:",<.>/?''', 'A')  = PIPE_ID

)
	group by	tablename, grid, quad
  	order by	tablename, grid, quad;

--	====================================================================================     
	commit;
	alter rollback segment rb1 offline;


