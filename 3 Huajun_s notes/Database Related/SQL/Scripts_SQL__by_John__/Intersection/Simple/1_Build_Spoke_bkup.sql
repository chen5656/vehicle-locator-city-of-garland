--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================


	insert --+ append
	into	 garland.Temp_View2

	select	
		v.road_id,
		v.this_node,
		v.terminal,

		trunc(r.addr_lo, -2),
		r.addr_pfx,
		r.addr_name,
		r.addr_type,
		r.addr_sfx

	from	garland.Temp_View1	V,
		garland.TRVEHRCL		R

	where	r.mslink	= to_number(v.road_id);











