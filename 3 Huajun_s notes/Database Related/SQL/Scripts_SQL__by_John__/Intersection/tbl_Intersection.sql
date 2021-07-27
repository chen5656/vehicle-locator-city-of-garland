	set echo		off;
--	=============================================================
--	create intersection table
--	index by name
--	index by node id
--	=============================================================

/*
--	=============================================================

	create or replace type	region$v	as varray (4)  of varchar2(5);

	create or replace type	str$		as object
(
	pfx		varchar2(02),
	name		varchar2(20),
	type		varchar2(04),
	sfx		varchar2(02)
);

--	=============================================================

	drop table		garland.intersection;

	create table	garland.intersection
(
	str1_blok		number(5),
	str1			str$,

	str2_blok		number(5),
	str2			str$,

	addr1_block		number  (05),		
	addr1_pfx		varchar2(02),	
	addr1_name		varchar2(30),	
	addr1_type		varchar2(04),	
	addr1_sfx		varchar2(02),	

	addr2_block		number  (05),		
	addr2_pfx		varchar2(02),	
	addr2_name		varchar2(30),	
	addr2_type		varchar2(04),	
	addr2_sfx		varchar2(02),	

	corner_compass	varchar2(02),	--	"N","NE" corner of intersection
	twin_compass	varchar2(02),	--	"N","NE" node   of double junction

	node_id		varchar2(09),	--	smaller street id + bigger street id
	intersect_id	varchar2(14),	--	type + id1 + dot + id2 + type  

	zip_code			region$v,
	subdiv_id			region$v,
	council_id			region$v,
	police_beat			region$v,
	fire_district		region$v,
	code_inspect_area		region$v
)

	tablespace		gis_data
				nologging
				pctfree 10m	pctused 90
	storage	 (	initial 10m	next 10m  pctincrease 0);

--	=============================================================

	create index	garland.intersection_name
		on		garland.intersection (addr1_name)

	tablespace		gisindx
				nologging
				pctfree 5	pctused 90
	storage 	(	initial 10m  next 10m  pctincrease 0 );

--	=============================================================

	create index	garland.intersection_node_id
		on		garland.intersection(node_id)

	tablespace		gisindx
				nologging
				pctfree 5	pctused 90
	storage 	(	initial 2m  next 2m  pctincrease 0 );

--	=============================================================
*/
