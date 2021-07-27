	set echo off;
	set heading off;
	set pagesize	99999;


	select nvl(ltrim(manhole_id), 'SS'||map_grid||map_quad||'-'||manhole_num||'MH')		
		   ||','|| manhole_size ||','|| to_char(asbuilt_date,'yyyy-mm-dd')
		   " "
    from sde.sewer_manhole_eng
	where map_grid > '0' and map_quad >= 'A' 
	order by map_grid, map_quad, manhole_id;
