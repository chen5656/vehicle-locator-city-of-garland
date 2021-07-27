
--	=================================================================	
--	update police beats

	create or replace view		intersection_region_view
	(		node_id, addr1_name, addr1_type, addr1_block, addr2_name, addr2_type, addr2_block,
	 		region,		kind,			empty		)	
	as select	node_id, addr1_name, addr1_type, addr1_block, addr2_name, addr2_type, addr2_block,
			CODE_INSPECT_AREA,	'CODE',		'0'			from Intersection;

--	@c:\deacutis\scripts\regions\block\11_Update_Block_Block_Intersection.sql;

