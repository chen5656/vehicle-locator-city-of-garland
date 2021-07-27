	set echo off;
--	====================================================================================
--	show duplicate IDs in utility table
--	====================================================================================

	select  'UTSANMH' "TABLE ", map_grid "GR", map_quad "Q", manhole_num "NUM", mslink
	from	  utsanmh
	where	 ( map_grid, map_quad, manhole_num )
	in

(
	select map_grid, map_quad,  manhole_num
	from  utsanmh
	where	map_grid is not null
	and	map_quad is not null
	and	manhole_num is not null
	group by	map_grid, map_quad,  manhole_num
	having	count(*) > 1
)
	order by 1,2,3,4;


--	====================================================================================
	set echo on;
