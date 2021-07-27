--	====================================================================================
	insert /*+ append */	into	utility_num_control
	select  tablename, grid, quad, max(num) num		from
(
	select
		'===AAA==='					tablename,
		rtrim(map_grid)				grid,
		map_quad					quad,
		rtrim(===BBB===)				num
	from	===AAA===
	where	map_grid	>   0
	and	map_quad 	>= 'A'
	and	===BBB===	>   0 
	union
	select	
		'===AAA==='												tablename,
		substr (===CCC===, 03,	instr (===CCC===, '-') -4)	 				grid,
		substr (===CCC===,	instr (===CCC===, '-') -1,  1) 				quad,
		substr (===CCC===,	instr (===CCC===, '-') +1,  
						length(===CCC===) - instr(===CCC===, '-') -2)		num
	from	===AAA===
	where	length(===CCC===) >= 8 
)
	where		grid is not null
	and		quad is not null
	and		num  is not null
	and		ltrim(grid, '0123456789') is null
	and		ltrim(num,  '0123456789') is null
	and		quad	>= 'A'

	group by	tablename, grid, quad;
--	====================================================================================
