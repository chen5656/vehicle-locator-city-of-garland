	set echo		off;
	set serveroutput	on		size 999999;
--	=================================================================	
/*
	select count(*) 				"BLOCKS"	from adrBlock_Side;
	select count(COUNCIL_ID)		"COUNCIL"	from adrBlock_Side;
	select count(POLICE_BEAT) 		"BEAT"	from adrBlock_Side;
	select count(POLICE_DISTRICT) 	"DISTRICT"	from adrBlock_Side;
	select count(FIRE_DISTRICT) 		"FIRE"	from adrBlock_Side;
	select count(CODE_INSPECT_AREA) 	"CODE"	from adrBlock_Side;
	select count(SUBDIV_ID)	 		"SUB DIV"	from adrBlock_Side;
	select count(ZIP_CODE)	 		"ZIP CODE"	from adrBlock_Side;
*/
--	=================================================================	
--	update block side region

	create or replace view		garland.block_region_view	
	(
		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity, block_id, row_id,

	 	region_type,	region_id,				empty_id	
	)	
	as select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity, block_id, rowid,

		'BEAT',		POLICE_BEAT,			'0'	
--		'DISTRICT',		POLICE_DISTRICT,			'0'			


		from	garland.Block_Side;


--	=================================================================	

--	@c:\deacutis\scripts\regions\block\11_Update_Block_Execute.sql;

--	=================================================================	
/*
	select count(COUNCIL_ID)		"COUNCIL"	from adrBlock_Side;
	select count(POLICE_BEAT) 		"BEAT"	from adrBlock_Side;
	select count(POLICE_DISTRICT) 	"DISTRICT"	from adrBlock_Side;
	select count(FIRE_DISTRICT) 		"FIRE"	from adrBlock_Side;
	select count(CODE_INSPECT_AREA) 	"CODE"	from adrBlock_Side;
	select count(SUBDIV_ID)	 		"SUB DIV"	from adrBlock_Side;
	select count(ZIP_CODE)	 		"ZIP CODE"	from adrBlock_Side;
*/
--	=================================================================	

