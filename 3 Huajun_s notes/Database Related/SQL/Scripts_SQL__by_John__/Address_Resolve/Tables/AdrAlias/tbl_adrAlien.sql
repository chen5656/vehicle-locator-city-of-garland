
	drop table		garland.adrAlien;		

	create table	garland.adrAlien
	(
		alias_pfx		varchar2(02),
		alias_name		varchar2(40),
		alias_type		varchar2(04),
		alias_sfx		varchar2(02),
	
		alias_lo		number,
		alias_hi		number,
		addr_min		number,

		addr_pfx		varchar2(02),
		addr_name		varchar2(30),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),

		alias_weight	number,			-- jul 2003
		alias_match		number,			-- nov 2003
		alias_how		varchar2(05),

		constraint	 adrAlien_pkey	 primary key	
				(alias_name, alias_type, alias_pfx, alias_sfx, alias_lo)
		using index tablespace	gisindx	
				storage  ( initial 1m  next 1m  pctincrease 0)
	)
	tablespace	gis_data
	storage	( initial 1m  next 1m  pctincrease 0 )
	;

--	===================================================================================================================	

