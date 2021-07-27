	set echo	off;
--	==============================================================================
--	Preferred strategy

--	Insert new Block Control records to Temporary table
--	Update  Block Control records on Temporary table
--	Then transfer Temporary Table results to actual Block_Control table

--	==============================================================================

--	A1

	truncate table	garland.GIS_Temp1;

	create or replace view	garland.block_control_vw
(
	record_id,	
	block_id,	

	action,	
	differ,	

	addr_block,	
	addr_pfx,	
	addr_name,	
	addr_type,	
	addr_sfx,	

	repl_block,	
	repl_pfx,	
	repl_name,	
	repl_type,	
	repl_sfx,	

	start_lo,
	stop_lo,
	stop_hi,
	counter,

	source,	
	add_date
)
	as
	select	item01, item02, item03, item04, 
			item05, item06, item07, item08, item09,
			item10, item11, item12, item13, item14,
			item15, item16, item17, item18, 
			item19, item20 

	from		garland.gis_temp1;

--	=========================================================
	set echo	on;
