	set echo		off;
	set serveroutput	on		size 999999;
--	=================================================================	
--	Update Radial Side Region
--	Define Block  Side Region view to look at Radial Side Region
--	=================================================================	

	create or replace view		garland.Block_Region_view	
	(
		addr_name,		addr_type,		addr_pfx,	addr_sfx, 

		addr_block, 	addr_parity, 	block_id, 	row_id,

	 	region_type,	region_id,		empty_id	
	)	

	as select

		r.addr_name,	r.addr_type, r.addr_pfx, r.addr_sfx, 

		r.addr_lo,		s.parity,	 s.road_id,  s.row_id,

		s.region_type,	s.region_id, 		'0000'

		from	garland.Radial_Side	s,
			garland.trvehRCL		r

		where	s.road_id	r.mslink;

--	=================================================================	

--	@c:\deacutis\scripts\regions\block\11_Update_Block_Execute.sql;

--	=================================================================	

