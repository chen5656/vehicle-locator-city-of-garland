	set echo off;
--	===========================================================
--	Intersections (nodes) of many different streets
--	===========================================================

--	desc temp_view3;


	select distinct
	 	lpad(node_id,   05)	node_id, 
		rpad(addr_name, 20) 	name,
		rpad(addr_type, 04)	street

	from temp_view3
	where	node_id	in

(

	select node_id
--	select count(*)

	from	temp_view3
	group by node_id

	having count (distinct addr_name || addr_type ) > 2
--	having count (distinct addr_name || addr_type || addr_pfx || addr_sfx ) > 2

)

	order by 1,2,3;

--	order by node_id, addr_name, addr_type, addr_pfx, addr_sfx, addr_blok;
	
--	===========================================================
	set echo on;
