
--	look for gaps in cdreladr addresses
--	the standard difference for even or odd addresses is 04
--	a gap is any 2 addresses in which the addr_num difference = 08


	drop table		adrgap;

	create table	adrgap
	(
		addr_num			number(06),
		addr_pfx			varchar2(02),
		addr_name			varchar2(20),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02)

	)
		tablespace	gis_data
		storage	(initial 1m  next 1m  pctincrease 0);



	create index	adrgap_x_name
		on		adrgap  (addr_name)
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0);



	comment on table	adrgap is 'possible missing address when address number jumps by 08';
