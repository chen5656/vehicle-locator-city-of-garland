
	drop table		garland.adrResult_Input;

	create table	garland.adrResult_Input
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

		parcel_id		varchar2(11),
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
	storage 	(initial 4m  next 1m  pctincrease 0);

--	==================================================================================================

	create index	garland.adrResult_Input_seq
		on		garland.adrResult_Input (rec_seq)
	tablespace		gisindx
	nologging
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================
/*
	create index	garland.adrResult_Input_pid
		on		garland.adrResult_Input (parcel_id)
	tablespace		gisindx
	nologging
	storage		(initial 2m  next 1m  pctincrease 0);
*/
--	==================================================================================================
