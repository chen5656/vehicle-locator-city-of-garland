	set echo	off;
--	==============================================================================
--	display centerline records for which no street id or block id were found
--	==============================================================================

	select
			lpad(s.esri_node,08)	"node",
			r.addr_lo			"        LO",
			r.addr_hi			"        HI",
			r.addr_pfx			" ",
			r.addr_name			"street",
			r.addr_type			" ",
			r.addr_sfx			" ",
			r.mslink			"    mslink",
			lpad(s.street_id,09)	"street id",		
			lpad(s.block_id, 08)	"block id"		

	from		trvehrcl	r,
			spoke		s

	where		s.road_id		 = r.mslink
	and	(	nvl(s.street_id,0) = 0
	or		nvl(s.block_id, 0) = 0		)

	order by	s.esri_node, r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_lo;

--	==============================================================================
	set echo	on;

