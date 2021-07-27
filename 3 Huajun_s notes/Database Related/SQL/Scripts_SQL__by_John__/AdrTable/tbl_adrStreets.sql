
	drop table		adrStreets;

	create table	adrStreets
	(
		addr_pfx			varchar2(02),
		addr_name			varchar2(30),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02),

		street_id			number(08),
		addr_compress		varchar2(30),
		addr_compact		varchar2(30),
		addr_reduced		varchar2(30),
		addr_begin			varchar2(30),
		addr_ending			varchar2(30),
		addr_soundex		varchar2(20),
		addr_permute		number
	)
		tablespace	gis_data
		storage ( initial 320k  next 320k  pctincrease 0 );

--	========================================================================

alter table		adrStreets
add
(
	constraint	adrStreets_pkey	
	primary key	(addr_name, addr_type, addr_pfx, addr_sfx)

	using	index
	tablespace	gisindx
	storage 	(initial 320k next 320k  pctincrease 0)
);

--	========================================================

create index	adrStreets_x_compress
	 on 		adrStreets
			(addr_compress)
	tablespace	gisindx
	storage ( initial 320k  next 320k  pctincrease 0 );


create index	adrStreets_x_compact
	 on 		adrStreets
			(addr_compact)
	tablespace	gisindx
	storage ( initial 320k  next 320k  pctincrease 0 );



create index	adrStreets_x_reduced
	 on 		adrStreets
			(addr_reduced)
	tablespace	gisindx
	storage ( initial 320k  next 320k  pctincrease 0 );



create index	adrStreets_x_soundex
	 on 		adrStreets
			(addr_soundex)
	tablespace	gisindx
	storage ( initial 320k  next 320k  pctincrease 0 );


--	========================================================

