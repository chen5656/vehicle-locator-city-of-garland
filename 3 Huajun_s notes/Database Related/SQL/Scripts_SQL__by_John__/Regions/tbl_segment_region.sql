
--	==================================================================

	create table  trvehrcl_region
(
		segment_id			number,
		zip_code			varchar2(05), 
		subdiv_id			varchar2(05),
		council_id			varchar2(01),
		police_beat			varchar2(03),
		fire_district		varchar2(01),
		code_inspect_area		varchar2(02)
)
	tablespace	gis_data
	storage	( initial 1m  next 1m  pctincrease 0 );

--	==================================================================

	create index trvehrcl_region_idx
		on	 trvehrcl_region  (segment_id)
	tablespace	gisindx
	storage	( initial 1m  next 1m  pctincrease 0 );

--	==================================================================

--	desc cdrelpar;
--	desc trvehrcl;
