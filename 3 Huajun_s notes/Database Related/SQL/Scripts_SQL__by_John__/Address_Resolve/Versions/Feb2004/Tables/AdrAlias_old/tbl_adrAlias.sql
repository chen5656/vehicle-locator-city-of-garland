--	===================================================================================================================	
--	street correction table

--	any address matching an "alias_" street & range should be changed to the "addr_" street
--	an asterick in an alias_ column is a wild card 
--	a  null     in an addr_  column indicates the user column should be left unchanged
--	===================================================================================================================	

	drop table		garland.adrAlias;
	create table	garland.adrAlias
	(
		alias_pfx		varchar2(10),
		alias_name		varchar2(80),
		alias_type		varchar2(10),
		alias_sfx		varchar2(10),
	
		alias_lo		number,
		alias_hi		number,
		addr_min		number,

		addr_pfx		varchar2(02),
		addr_name		varchar2(30),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),

		alias_weight	number,			-- jul 2003
		alias_match		number,			-- nov 2003
		alias_how		varchar2(08),

		alias_reduced	varchar2(30),
		alias_compact	varchar2(30),
		alias_compress	varchar2(30),

		constraint adrAlias_pkey primary key	
				(alias_name, alias_type, alias_pfx, alias_sfx, alias_lo)
				using index tablespace gisindx
						storage (initial 1m  next 1m  pctincrease 0)
	)
	tablespace	gis_data
	storage	(initial 1m  next 1m  pctincrease 0);

--	===================================================================================================================	

	create index	garland.adrAlias_compact
		on		garland.adrAlias (alias_compact)

	tablespace	gisindx
	storage	(initial 1m  next 1m  pctincrease 0);

--	===================================================================================================================	
