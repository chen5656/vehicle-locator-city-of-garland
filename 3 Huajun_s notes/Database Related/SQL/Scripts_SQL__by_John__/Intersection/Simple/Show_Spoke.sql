	set echo off;
	
	select
			lpad(node_id,  5)		node,
			lpad(road_id,  5)		road,
			lpad(junction, 5)		junc,

			lpad(addr_blok, 8)	block,
			rpad(addr_pfx,  3)	pre,
			rpad(addr_name, 20)	name,
			rpad(addr_type, 5)	type,
			rpad(addr_sfx,  5)	suf,

			to_char(to_number(x_vector),'S9999')		x

	from		garland.Temp_View3

	where		rownum < 11
	;
		
	set echo on;
