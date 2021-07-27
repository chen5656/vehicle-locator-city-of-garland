
--	drop table		garland.Block;

	create table	garland.Block
(
	block_id		number,

	addr_block		number,	
	addr_pfx		varchar2(02),
	addr_name		varchar2(30),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),

	start_lo		number,
	stop_lo		number,
	stop_hi		number,	
	counter		number,

	intersect1_id	varchar2(20),
	intersect2_id	varchar2(20),

	constraint	Block_pkey 	primary key	
			(addr_name, addr_block, addr_type, addr_pfx, addr_sfx)
)
	organization index
	tablespace	 gisindx
	storage	(initial 1m  next 1m  pctincrease 0)
	;

--	================================================================

	drop synonym	adrBlock;	

	create synonym	adrBlock	for Block;

--	================================================================
