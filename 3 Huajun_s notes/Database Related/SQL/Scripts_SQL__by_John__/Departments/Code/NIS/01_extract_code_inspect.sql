	set echo	off;
	set timing	on;
--	================================================================================
--	extract code inspection
--		specify output file
--		specify date range
--	================================================================================

--	truncate table	GARLAND.NSA_CODE_INSPECT	reuse storage;

	drop synonym	garland.syn_gis_table;
	create synonym	garland.syn_gis_table for		garland.NSA_CODE_INSPECT	;

--	================================================================================

	alter rollback segment rb1	online;
	commit;
	set transaction	use rollback segment rb1;

	truncate table	plan_table		reuse storage;
	explain plan	set statement_id = 'test'		for

--	================================================================================

	insert into	garland.syn_gis_table

	select
--+  	all_rows	full(i)

		i.case_number,			
		i.inspection_date,					
		i.case_closed_date,				

		a.address_number,		
		nvl (rtrim (a.address_prefix),' ')			 	addr_pfx,			
		rtrim (a.address_name)				 		addr_name,				
		nvl (rtrim (a.address_type,  ' ,'),' ')			addr_type,			
		nvl (rtrim (a.address_suffix,' ,'),' ')			addr_sfx,
		null									unit_code,
		nvl (rtrim (ltrim (a.address_suppl#),' ,'),' ') 	unit_num,
		a.zip_code,						

		null, null,					--	citation issue & comply date

		v.action,			
		i.follow_up_action,		
		v.status,						
		v.code_id,	
		v.violation_id,				
		v.violation,

		i.inspector_initials,
--		null,						--	instigator (relocation)
		null, null,					--	legal1, legal2
		null,						--	inspect area
		a.council_district,
		null,	null, null, null, null,		--	subdiv, nsa, parcel, segment, verify
		null						--	instigator (new)

	from	 cog.inspection@cdep.world		i
		,cog.codeaddr@cdep.world		a
		,cog.case_violation@cdep.world	v

	where to_char (i.inspection_date, 'yyyy') = 2003	--	CHANGE

	and	i.addr_id	  	= a.addr_id		(+)
	and	i.case_number 	= v.case_number	(+)

--	or	i.inspection_date	between spec_lo_date and spec_hi_date )
--	and	i.case_number between 200000 and 201111


	and	ROWNUM < 1111						--	T E S T   
	;

--	================================================================================

	select * from explain_plan;

	Rollback;
	commit;
	alter rollback segment rb1	offline;

--	analyze table	garland.NSA_CODE_INSPECT		compute statistics;

	select count(*) "NIS Inspect" from nsa_code_inspect;

--	================================================================================
	set echo	on;
	set timing	off;
