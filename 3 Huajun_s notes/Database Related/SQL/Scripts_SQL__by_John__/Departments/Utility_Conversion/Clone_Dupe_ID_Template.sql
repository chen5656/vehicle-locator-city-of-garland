--	===================================================================================
--	TEMP_VIEW1	
--	AAA		TABLE NAME
--	BBB		NUM COLUMN
--	===================================================================================

	select  '===AAA===' "TABLE ", map_grid "GR", map_quad "Q", ===BBB=== "NUM", mslink
	from	  ===AAA===
	where	 ( map_grid, map_quad, ===BBB=== )
	in
(
	select map_grid, map_quad,  ===BBB===
	from  ===AAA===
	where	map_grid is not null
	and	map_quad is not null
	and	===BBB=== is not null
	group by	map_grid, map_quad,  ===BBB===
	having	count(*) > 1
)
	order by 1,2,3,4;
