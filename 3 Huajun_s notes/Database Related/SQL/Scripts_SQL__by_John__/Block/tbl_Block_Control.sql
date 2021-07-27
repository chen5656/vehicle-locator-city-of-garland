	set echo	off;
--	=============================================================================

	drop table		garland.Block_Control;

	create table	garland.Block_Control
(
	record_id		number,
	block_id		number,

	action		varchar2(3),		--	None, Insert, Update, Delete
	differ		varchar2(3),		--	01,02,03 = New blk,str,name  
								--	11,12,13 = Old blk,str,name
	addr_block		number,
	addr_pfx		varchar2(02),
	addr_name		varchar2(20),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),

	repl_block		number,	
	repl_pfx		varchar2(02),	
	repl_name		varchar2(20),	
	repl_type		varchar2(04),	
	repl_sfx		varchar2(02),	

	start_lo		number,
	stop_lo		number,
	stop_hi		number,
	counter		number,

	source		varchar2(1),		--  Centerline, Address, Block
	add_date		date
)

	tablespace		gis_data
	storage		(initial 50k  next 50k  pctincrease 0)
	nologging;

--	=============================================================================

	alter table	garland.Block_Control
	add	constraint	  Block_Control_pkey
		primary key	  (record_id)

	using index
	tablespace		gisindx
	storage		(initial 50k  next 50k  pctincrease 0)
	nologging;

--	=============================================================================
	set echo	on;

