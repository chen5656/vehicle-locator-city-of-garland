
--	drop table	 garland.intersection;	

	create table garland.intersection
(
	addr1_block		number,
	addr1_pfx		varchar2(02),
	addr1_name		varchar2(20),
	addr1_type		varchar2(04),
	addr1_sfx		varchar2(02),

	addr2_block		number,
	addr2_pfx		varchar2(02),
	addr2_name		varchar2(20),
	addr2_type		varchar2(04),
	addr2_sfx		varchar2(02),

	corner_compass	varchar2(02),
	twin_compass	varchar2(02),

	node_id		number,
	intersect_id	number,

	road1_id		number,
	road2_id		number,

      tax_acct          varchar2(17),
      subdiv_id         varchar2(05),
      council_id        varchar2(01),
      zip_code          varchar2(05),
      code_inspect_area varchar2(02),
      fire_district     varchar2(01),
      police_beat       number(02)
)
	tablespace		gis_data,
	storage		(initial 5m  next 1m  pctincrease 0);

--	======================================================================

	create index	garland.intersection_name
		on		garland.intersection (addr1_name)
	tablespace		gisindx
	storage		(initial 5m  next 1m  pctincrease 0);

--	======================================================================
