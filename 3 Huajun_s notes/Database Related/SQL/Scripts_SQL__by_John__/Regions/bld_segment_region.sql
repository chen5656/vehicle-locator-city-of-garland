
--	REBUILD TRVEHRCL_REGION
--	DISPLAY SEGMENTS WITH MULTIPLE VALUES OF A PARTICULAR REGION

	set echo off;
	set timing on;

--	====================================================================

	truncate table	trvehrcl_segment	reuse storage;

	alter rollback segment	rb1	online;
	set transaction use rollback segment rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	insert into	trvehrcl_region
(
	select distinct
		t.segment_id,
		p.zip_code, 
		p.subdiv_id,
		p.council_id,
		p.police_beat,
		p.fire_district,
		p.code_inspect_area

	from	trvehrcl		t,
		cdreladr		a,
		cdrelpar		p

	where	a.parcel_id	= p.parcel_id
	and	a.addr_name	= t.addr_name
	and	a.addr_type	= t.addr_type
	and	a.addr_pfx	= t.addr_pfx
	and	a.addr_sfx	= t.addr_sfx
	and	a.addr_num >= t.addr_lo
	and	a.addr_num <= t.addr_hi
);


--	select * from explain_plan;

	commit;
	alter rollback segment	rb1	offline;


--	desc cdrelpar;
--	desc trvehrcl;

	set echo on;
	set timing off;

--	====================================================================
/*

--	display multiple region values within segment id

	select tr.segment_id,
		 tr.COUNCIL_ID
	from   trvehrcl_region	TR,

(
	select segment_id, 
		count(*) " "

	from	trvehrcl_region
	where	nvl(COUNCIL_ID, ' ') > ' '	

	group by 	segment_id
	having	count(distinct COUNCIL_ID) > 1
)	

	VW
	where	TR.segment_id = VW.segment_id
;

*/

--	====================================================================
	set echo off;

	select	rpad(segment_id, 07)		"segment",
			zip_code				"zip",
			rpad(subdiv_id, 06)		"subdiv",
			rpad(council_id,07)		"council",
			rpad(police_beat,04)		"beat",
			rpad(fire_district,04)		"fire",
			rpad(code_inspect_area,04)	"code"
	from		trvehrcl_region
	where		rownum < 22;

	set echo on;
--	====================================================================

