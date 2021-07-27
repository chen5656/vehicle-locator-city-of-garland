	set echo	off;
--	=================================================================================
--	Merge rental Address info from specific Source into previous Merged output
--	=================================================================================

--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'rental'	into garland.plan_table		for
--	=================================================================================

	insert --+	append
	into	garland.TEMP_SYN2				-- 
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx,

	address_id,  parcel_id, 
	district,
	KNOWN, DCAD, SECTION8,  HOMESTEAD
)

--	=================================================================================
--	OBTAIN RENTAL ADDRESSES IN PREVIOUS EXTRACT
--	MATCH SCRUBBED INPUT RENTAL ADDRESSES TO PREVIOUS EXTRACT


	select	--+ index( R ) index( V )
		r.addr_name, r.addr_num, r.addr_type, r.addr_pfx, r.addr_sfx, 

		nvl(s.address_id, r.segment_id),
		nvl(s.parcel_id,  r.parcel_id),

		decode(v.source, 'KNOWN',    v.district,s.DISTRICT),

		decode(v.source, 'KNOWN',    v.app_key, s.KNOWN),
		decode(v.source, 'DCAD',     v.app_key, s.DCAD ),
		decode(v.source, 'SECTION8', v.app_key, s.SECTION8),
		decode(v.source, 'HOMESTEAD',v.app_key, s.HOMESTEAD)


	from	garland.TEMP_SYN1		S,		--  Previous Address info to be updated ...
		garland.adrResult		R,		--  by Scrubbed address
		garland.Temp_View		V		--  Original data 	

	where	s.addr_name		= r.addr_name	 
	and	s.addr_type		= r.addr_type	 
	and	s.addr_pfx		= r.addr_pfx	 
	and	s.addr_sfx		= r.addr_sfx	 
	and	s.addr_num		= r.addr_num	

	and	r.rec_key		= v.app_key 	 
	and	r.appl_unit2	= v.source	 	 
	and	r.appl_unit2	= :spec_source	 	

	and (	rtrim(r.addr_unit1) is null
	or	r.addr_unit1 in ('KNOWN', 'DCAD', 'SECTION8', 'HOMESTEAD') )


--	=================================================================================
--	

	UNION ALL


	select S.*
	from	garland.TEMP_SYN1		S

	where not exists					--  
(
	select 'x'
	from	garland.adrResult		R,
		garland.Temp_View		V

	where	s.addr_name		= r.addr_name	
	and	s.addr_type		= r.addr_type	
	and	s.addr_pfx		= r.addr_pfx	
	and	s.addr_sfx		= r.addr_sfx	
	and	s.addr_num		= r.addr_num	

	and	v.app_key 		= r.rec_key 
	and	r.appl_unit2	= v.source
	and	r.appl_unit2	= :spec_source

	and (	rtrim(r.addr_unit1) is null
	or	r.addr_unit1 in ('KNOWN', 'DCAD', 'SECTION8', 'HOMESTEAD') )
)

--	=================================================================================
--	OBTAIN SCRUBBED RENTAL ADDRESSES THAT DON'T MATCH PREVIOUS EXTRACT


	UNION ALL

	select	--+ index( R ) index ( V )
		r.addr_name, r.addr_num, r.addr_type, r.addr_pfx, r.addr_sfx, 

		r.segment_id,
		r.parcel_id,

		decode(v.source, 'KNOWN',    v.DISTRICT,'0'),

		decode(v.source, 'KNOWN',    v.app_key, '0'),
		decode(v.source, 'DCAD',     v.app_key, '0' ),
		decode(v.source, 'SECTION8', v.app_key, '0'),
		decode(v.source, 'HOMESTEAD',v.app_key, '0')

	from	garland.adrResult		R,		--  Scrubbed address to be added
		garland.Temp_View		V		--  Original data 

	where	v.app_key 		= r.rec_key 
	and	r.appl_unit2	= v.source
	and	r.appl_unit2	= :spec_source

	and (	rtrim(r.addr_unit1) is null
	or	r.addr_unit1 in ('KNOWN', 'DCAD', 'SECTION8', 'HOMESTEAD') )


	and not exists					--  When address does not exist in previous output
(
	select 'x'
	from	garland.TEMP_SYN1		S		
	where	s.addr_name		= r.addr_name	
	and	s.addr_type		= r.addr_type	
	and	s.addr_pfx		= r.addr_pfx	
	and	s.addr_sfx		= r.addr_sfx	
	and	s.addr_num		= r.addr_num	
)

--	=================================================================================
	;
--	=================================================================================

	commit;		

--	=================================================================================

	select
		rpad(	sign(known) || sign(dcad) || sign(section8) || sign(homestead),  30)
								"known dcad section8 homestead",
			count(*)				total
	from		garland.Temp_Syn2
	group by	sign(known) || sign(dcad) || sign(section8) || sign(homestead);

--	=================================================================================

--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;

--	=================================================================================




