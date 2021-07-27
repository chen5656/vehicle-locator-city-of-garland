	set echo	off;
	set timing	off;
--	===============================================================================================
--	Define views of temporary block tables and of permanent block side & intersection tables
--	Decide which region to focus on	
--	===============================================================================================


	drop view	intersection_region_view;
	drop view	block_region_view;
	drop view	block_region1_view;
	drop view	block_region2_view;
	drop view	block_region3_view;

--	===============================================================================================
--	Focus on a specific region in Block Side table
--	===============================================================================================

	create or replace view	block_region_view	
	(	
		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity, block_id, row_id,
	 	region,		kind,		empty		
	)	
	as select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity, block_id, rowid,

--	------------------------------------------------------------------------------------------------

		POLICE_BEAT,		'BEAT',				'0'

--		POLICE_DISTRICT,		'DISTRICT',				'0'			

--	------------------------------------------------------------------------------------------------

	from garland.adrBlock_Side;

--	===============================================================================================
--	Focus on a specific region in the intersection table
--	===============================================================================================

	create or replace view	intersection_region_view	
	(
		addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
		addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block, 
		intersect_id,		node_id,	row_id,
	 	region,			kind,		empty		
	)	
	as select	
		addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
		addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block, 
		intersect_id,		node_id,	rowid,

--	------------------------------------------------------------------------------------------------

		POLICE_BEAT,		'BEAT',			'0'

--		POLICE_DISTRICT,		'DISTRICT',			'0'			

--	------------------------------------------------------------------------------------------------

	from garland.intersection;

--	===============================================================================================
--	View of temporary table holding blocks lying entirely within focus region
--	Obtained from block_region_view (below)
--	===============================================================================================

	create or replace view	block_region1_view
(
	addr_name,	
	addr_type,	
	addr_pfx,	
	addr_sfx,	
	addr_block,	
	region1,		
	region2			
)
	as select	item01, item02, item03, item04, item05, item06, item07
	from		gis_temp1;

--	===============================================================================================
--	View of temporary block table holding blocks on boundary of focus region
--	So far, this is neither populated nor used
--	===============================================================================================

	create or replace view	block_region2_view
(
	addr_name,	
	addr_type,	
	addr_pfx,	
	addr_sfx,	
	addr_block,	
	region1,		
	region2			
)
	as select	item01, item02, item03, item04, item05, item06, item07
	from		gis_temp2;

--	===============================================================================================
--	Temporary table holding blocks obtained from ESRI extract
--	ESRI extract (gis_objects) contains TRVEHRCL mslink with focus region on both sides of centerline
--	===============================================================================================

	create or replace view	block_region3_view
(
	addr_name,	
	addr_type,	
	addr_pfx,	
	addr_sfx,	
	addr_block,	
	region1,		
	region2			
)
	as select	item01, item02, item03, item04, item05, item06, item07
	from		gis_temp3;

--	===============================================================================================
	set echo on;
