
--	CREATE ONE TIME ONLY
--	STREET ID IS MAINTAINED BY ORACLE SEQUENCE


	create table	garland.Street
	(
		addr_pfx			varchar2(02),
		addr_name			varchar2(30),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02),

		street_id			number(08),

		addr_compress		varchar2(20),
		addr_compact		varchar2(20),
		addr_reduced		varchar2(20),
		addr_begin			varchar2(20),
		addr_ending			varchar2(20),
		addr_soundex		varchar2(20),
		addr_permute		number
	)
		tablespace	gis_data
		storage ( initial 100k  next 100k  pctincrease 0 );

--	========================================================================
--	========================================================================

alter table		garland.adrstreet
add
(
	constraint	street_pkey	
	primary key	(addr_name, addr_type, addr_pfx, addr_sfx)

	using	index
	tablespace	gisindx
	storage 	(initial 100k next 100k  pctincrease 0)
);

--	========================================================

create index	garland.street_compress
	 on 		garland.street (addr_compress)
	tablespace	gisindx
	storage ( initial 100k  next 100k  pctincrease 0 );


create index	garland.street_compact
	 on 		garland.street (addr_compact)
	tablespace	gisindx
	storage ( initial 100k  next 100k  pctincrease 0 );



create index	garland.street_reduced
	 on 		garland.street (addr_reduced)
	tablespace	gisindx
	storage ( initial 100k  next 100k  pctincrease 0 );



create index	garland.street_soundex
	 on 		garland.street (addr_soundex)
	tablespace	gisindx
	storage ( initial 100k  next 100k  pctincrease 0 );

--	========================================================
