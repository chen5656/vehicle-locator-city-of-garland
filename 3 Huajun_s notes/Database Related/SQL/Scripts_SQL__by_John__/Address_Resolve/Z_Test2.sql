	set echo	off;

--	assign sani_commercial naics code to sani_asset record key
--	adrResult contains verified sani_commercial addresses

	truncate table	gis_objects;

--	analyze table	sani_asset		compute statistics;
--	analyze table	gis_verify_addr	compute statistics;
--	analyze table	adrResult1		compute statistics;
	truncate table	plan_table;

--	=========================================================================
--	explain plan	set statement_id = 'aaa'	for

	insert into	gis_objects	(item01, item02, item03)

	select	distinct
			lpad(c.rec_key,5,'0'),
			a.rec_key,
			a.busi_type

	from		adrResult1			c,		--	scrubbed sani_commercial 
(
	select
			r.addr_name,
			r.addr_num,
			r.addr_type,
			r.addr_pfx,
			r.addr_unit,
			max(s.rec_key)	rec_key,
			max(s.busi_type)	busi_type
	from		sani_asset			s,
			adrResult			r
	where		s.rowid = r.rec_rowid
	group by	r.addr_name ,r.addr_num 	,r.addr_type ,r.addr_pfx 	,r.addr_unit 
	having	count(*) = 1
--	having	count(distinct s.busi_type) = 1
)							a

	where		c.addr_name	= a.addr_name
	and		c.addr_num	= a.addr_num
	and		c.addr_type	= a.addr_type
	and		c.addr_pfx	= a.addr_pfx
	and		c.addr_unit	= a.addr_unit

	and (c.addr_name, c.addr_num, c.addr_type, c.addr_pfx, c.addr_unit) in
(
	select 	addr_name, addr_num, addr_type, addr_pfx, addr_unit
	from	 	adrResult1
	group by	addr_name, addr_num, addr_type, addr_pfx, addr_unit
	having	count(*) = 1
)


	and not exists
(
	select	'x'
	from		gis_objects
	where		item01 = lpad(c.rec_key,5,'0')
)
;

--	=========================================================================
--	explain plan	set statement_id = 'bbb'	for

	insert into	gis_objects	(item01, item02, item03)

	select	distinct
			lpad(c.rec_key,5,'0'),
			a.rec_key,
			a.busi_type

	from		adrResult1			c,
(
	select
			r.addr_name,
			r.addr_num,
			r.addr_type,
			r.addr_pfx,
--			r.addr_unit,
			max(s.rec_key)	rec_key,
			max(s.busi_type)	busi_type
	from		sani_asset			s,
			adrResult			r
	where		s.rowid = r.rec_rowid
	group by	r.addr_name ,r.addr_num 	,r.addr_type ,r.addr_pfx 	--	,r.addr_unit 
	having	count(*) = 1
--	having	count(distinct s.busi_type) = 1
)							a


	where		c.addr_name	= a.addr_name
	and		c.addr_num	= a.addr_num
	and		c.addr_type	= a.addr_type
	and		c.addr_pfx	= a.addr_pfx
--	and		c.addr_unit	= a.addr_unit

	and (c.addr_name, c.addr_num, c.addr_type, c.addr_pfx) in
(
	select 	addr_name, addr_num, addr_type, addr_pfx
	from	 	adrResult1
	group by	addr_name, addr_num, addr_type, addr_pfx
	having	count(*) = 1
)


	and not exists
(
	select	'x'
	from		gis_objects
	where		item01 = lpad(c.rec_key,5,'0')
)
;


--	=========================================================================
--	explain plan	set statement_id = 'ccc'	for

	insert into	gis_objects	(item01, item02, item03)

	select
			distinct
			lpad(c.rec_key,5,'0'),
			a.rec_key,
			a.busi_type

	from		adrResult1			c,
(
	select
--+			use_hash (r)
			r.addr_name,
			r.addr_num,
--			r.addr_type,
--			r.addr_pfx,
--			r.addr_unit,
			max(s.rec_key)	rec_key,
			max(s.busi_type)	busi_type
	from		sani_asset			s,
			adrResult			r
	where		s.rowid = r.rec_rowid
	group by	r.addr_name ,r.addr_num 	--	,r.addr_type ,r.addr_pfx 	,r.addr_unit 
	having	count(*) = 1
--	having	count(distinct s.busi_type) = 1
)							a

	where		c.addr_name	= a.addr_name
	and		c.addr_num	= a.addr_num
--	and		c.addr_type	= a.addr_type
--	and		c.addr_pfx	= a.addr_pfx
--	and		c.addr_unit	= a.addr_unit


	and (c.addr_name, c.addr_num) in
(
	select 	addr_name, addr_num
	from	 	adrResult1
	group by	addr_name, addr_num
	having	count(*) = 1
)

	and not exists
(
	select	'x'
	from		gis_objects
	where		item01 = lpad(c.rec_key,5,'0')
);


--	=========================================================================

--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=========================================================================
/*

	select 'Total Records' " ", count(*) " "				from gis_objects;

	select 'Total Keys   ' " ", count(distinct item01) " "	from gis_objects;

	select 'Total Busi   ' " ", count(*) " "				from gis_objects	where item02 > '0';


	select 'Total Asset  ' " ", count(*) " "				from sani_asset;

	select 'Total Commer ' " ", count(*) " "				from sani_commercial;

*/
--	======================================================


