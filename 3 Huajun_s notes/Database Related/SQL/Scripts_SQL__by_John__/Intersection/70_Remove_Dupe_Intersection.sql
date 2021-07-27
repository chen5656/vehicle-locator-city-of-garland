	set echo	off;
	set timing	off;

--	=======================================================
--	remove duplicate records from intersection table
--	=======================================================

--	truncate table	plan_table;

	truncate table	gis_temp4	reuse storage;
	comment on table	gis_temp4		is 'dupe intersect';

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan	set statement_id = '1-insert'		for

	insert into	dupe_intersect

	select
			x.intersect_id, 
			c.esri_node,
			c.terminal1,
			x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			c.terminal2,
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			c.road_id1,	  c.road_id2,
			x.rowid	  row_id

	from		intersection	x,
			corner		c,
(
	select	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	from		intersection
	group by	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	having	count(*) > 1
)						A

	where		x.intersect_id	= c.intersect_id

	and		x.addr1_name	= A.addr1_name 
	and		x.addr1_type	= A.addr1_type
	and		x.addr1_pfx 	= A.addr1_pfx
	and		x.addr1_sfx 	= A.addr1_sfx
	and		x.addr1_block	= A.addr1_block

	and		x.addr2_name 	= A.addr2_name
	and		x.addr2_type 	= A.addr2_type
	and		x.addr2_pfx 	= A.addr2_pfx
	and		x.addr2_sfx 	= A.addr2_sfx
	and		x.addr2_block	= A.addr2_block;

	commit;
	alter rollback segment rb1	offline;

--	======================================================================

	select rpad(count(*),22)	"total dupe intersects" 
	from	 dupe_intersect;

--	======================================================================

	analyze table gis_temp4		compute statistics;	--	dupe intersect

--	======================================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan	set statement_id = '2-delete'		for

	delete from intersection
	where	rowid in
(
	select	row_id	from dupe_intersect
	minus
	select	row_id	from 
(
	select	D.intersect_id,
			min(D.row_id)	row_id
	from	
(
	select	intersect_id,
			row_id
	from		dupe_intersect	B, 
(
	select	min (intersect_id)	min_id,
			addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	from 		dupe_intersect	B
	group by	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
)						C

	where		B.intersect_id  = C.min_id

)						D
	group by	D.intersect_id
)
);

	commit;
	alter rollback segment rb1	offline;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_constraint;
--	select * from explain_cost;
--	======================================================================
	set echo on;
