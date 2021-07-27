--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
 --	----------------------------------------------
--	adrResult table, indexes, & synonym
--	----------------------------------------------

	drop table		garland.SCRUB_RESULT;

	create table	garland.SCRUB_RESULT
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
		appl_num		varchar2(20),
		alias_score		number,
		name_score		number,
		qual_score		number
	)

	tablespace	gis_data	nologging	pctfree 5;

--	==================================================================================================

	create index	garland.SCRUB_RESULT_KEY
		on		garland.SCRUB_RESULT (rec_key)
	tablespace		gis_index
				nologging
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================

	create index	garland.SCRUB_RESULT_AID
		on		garland.SCRUB_RESULT (segment_id)
	tablespace		gis_index
				nologging
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================

	create index	garland.SCRUB_RESULT_SEQ
		on		garland.SCRUB_RESULT (rec_seq)
	tablespace		gis_index
				nologging
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================
--	==================================================================================================
--	==================================================================================================

	drop table		garland.SCRUB_RESULT_INPUT;

	create table	garland.SCRUB_RESULT_INPUT
				tablespace gis_data	nologging	pctfree 5
	as select *	from	garland.SCRUB_RESULT	where rownum < 1;

--	==================================================================================================

	create index	garland.SCRUB_RESULT_INPUT_SEQ
		on		garland.SCRUB_RESULT_INPUT (rec_seq)
	tablespace		gis_index
				nologging
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================
