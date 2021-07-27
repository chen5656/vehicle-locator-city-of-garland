
--	drop table		garland.Block_Side;

	create table	garland.Block_Side
(
	addr_pfx			varchar2(02),
	addr_name			varchar2(30),
	addr_type			varchar2(04),
	addr_sfx			varchar2(02),
	addr_block			number,
	addr_parity			number,
	block_id			number,

	zip_code			varchar2(05),
	subdiv_id			varchar2(05),
	council_id			varchar2(01),
	code_inspect_area		varchar2(02),
	fire_district		varchar2(01),
	police_beat			number  (03),

	constraint	Block_Side_pkey	primary key	
			(addr_name, addr_block, addr_parity, addr_type, addr_pfx, addr_sfx)
	using index	tablespace	gisindx
			storage	(initial 1m  next 1m  pctincrease 0)
)
	tablespace	 gis_data
	storage	(initial 1m  next 1m  pctincrease 0)
	;

--	=================================================================

	create synonym adrBlock_side	for Block_Side;

--	=================================================================

