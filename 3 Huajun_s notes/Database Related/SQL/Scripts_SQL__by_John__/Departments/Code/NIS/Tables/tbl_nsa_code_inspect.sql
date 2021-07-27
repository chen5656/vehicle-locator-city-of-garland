
--	code inspection extract for specified date range
--	include codeaddr & case_violation & citation info

	drop table		nsa_code_inspect;

	create table	nsa_code_inspect
	(
		case_number			number(10),
		inspection_date		date,
		case_closed_date		date,

		addr_num			number(06),
		addr_pfx			varchar2(02),
		addr_name			varchar2(40),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02),
		unit_code			varchar2(06),
		unit_num			varchar2(06),
		zip_code			varchar2(05),

		issue_date			date,
		comply_date			date,

		action			number(02),
		follow_up_action		number(02),
		status			varchar2(01),
		code_id			varchar2(05),
		violation_id		varchar2(10),
		violation			varchar2(30),
		inspector			varchar2(25),
		instigator			varchar2(01),

		legal1			varchar2(35),
		legal2			varchar2(35),

		inspect_area		varchar2(02),
		council_id			varchar2(01),
		subdiv_id			varchar2(05),
		nsa_id			varchar2(05),
		parcel_id			varchar2(11),
		segment_id			number(06),
		verify_code			number(02)
	)
		tablespace	gis_data
		storage	( initial 3m  next 1m  pctincrease 0 );

--	=================================================================================
/*

	create index 	nsa_code_inspect_x_parcel
		on		nsa_code_inspect  (parcel_id)
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0 );


	create index 	nsa_code_inspect_x_subdiv
		on		nsa_code_inspect  (subdiv_id)
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0 );

*/
--	=================================================================================

