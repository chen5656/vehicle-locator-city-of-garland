
	drop table		adrpermute;

	create table	adrpermute
	(
		addr_num		number  (06),
		addr_pfx		varchar2(02),
		addr_name		varchar2(20),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),
		addr_permute	number
	)
		tablespace	gis_data
		storage  	(initial 1m  next 1m  pctincrease 0);


	create index	adrpermute_x_permute
		on		adrpermute  (addr_permute)
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0);


