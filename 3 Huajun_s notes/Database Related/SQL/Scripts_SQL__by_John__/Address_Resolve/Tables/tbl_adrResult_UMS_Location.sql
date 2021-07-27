
	drop table		garland.adrResult_UMS_Location;

	create table	garland.adrResult_UMS_Location
	(
		addr_num		varchar2(20),
		addr_pfx		varchar2(02),
		addr_name		varchar2(40),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),
		addr_code1		varchar2(06),			
		addr_unit1		varchar2(20),
		addr_code2		varchar2(06),			
		addr_unit2		varchar2(20),

		verify_code		varchar2(02),				
		do_parse		varchar2(30),			
		do_alias		varchar2(05),
		do_name		varchar2(01),
		do_qual		varchar2(20),

		rec_seq		number,
		rec_rowid		rowid,
		rec_key		varchar2(20),		

		parcel_id		varchar2(12),
		segment_id		varchar2(20),

		form_pfx		varchar2(02),
		form_name		varchar2(30),		
		form_type		varchar2(04),
		form_sfx		varchar2(02),
		form_code1		varchar2(06),
		form_unit1		varchar2(20),
		form_code2		varchar2(06),			
		form_unit2		varchar2(20),

		appl_pfx		varchar2(10),
		appl_name		varchar2(80),		
		appl_type		varchar2(10),
		appl_sfx		varchar2(10),
		appl_code1		varchar2(10),
		appl_unit1		varchar2(20),
		appl_code2		varchar2(10),			
		appl_unit2		varchar2(20),
		appl_num		varchar2(20)
	)
	tablespace	gis_data
	nologging
	storage 	(initial 20m  next 1m  pctincrease 0);

--	==================================================================================================

	create index	garland.adrResult_UMS_Location
		on		garland.adrResult_UMS_Location (rec_key)
	tablespace		gisindx
	nologging
	storage		(initial 4m  next 4m  pctincrease 0);

--	==================================================================================================
