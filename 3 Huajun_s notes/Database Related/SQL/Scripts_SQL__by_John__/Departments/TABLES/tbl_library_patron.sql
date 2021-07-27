
	drop table		library_patron;

	create table	library_patron
	(
		patron_key		varchar2(06),		

		addr_num		number,
		addr_pfx		varchar2(02),
		addr_name		varchar2(40),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),
		addr_code		varchar2(04),			
		addr_unit		varchar2(06),

		verify_code		varchar2(01),				
		census_blok		varchar2(06),
		parcel_id		varchar2(11),
		segment_id		varchar2(04),

		date_add		date,		
		date_modify		date,		
		date_scrub		date,		

		city			varchar2(10),
		zip			varchar2(05),
		patron_id		varchar2(05)
	)
	tablespace	gis_data
	storage 	(initial 2m  next 1m  pctincrease 0)
	pctfree 40	pctused 59;


--	==================================================================================================
/*

	create index	library_patron_
		on		library_patron_ ()
	tablespace		gisindx
	storage		(initial 2m  next 1m  pctincrease 0);

*/
--	==================================================================================================

