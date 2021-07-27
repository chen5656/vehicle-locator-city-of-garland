	set echo	off;
	set timing	off;
--	================================================================================
--	update code inspection address info with scrubbed address info
--	================================================================================

	alter rollback segment rb1	online;
	commit;
	set transaction	use rollback segment rb1;

	truncate table	plan_table		reuse storage;
	explain plan	set statement_id = 'test'		for

--	================================================================================

	update	garland.nsa_code_inspect	i

	set	(	addr_num,  addr_pfx,   addr_name, addr_type, addr_sfx,
			parcel_id, segment_id, verify_code	
		)
	=
(
	select	nvl(r.addr_num,   c.addr_num),
			nvl(r.addr_pfx,	c.addr_pfx), 
			nvl(r.addr_name,	c.addr_name), 
			nvl(r.addr_type,	c.addr_type),
			nvl(r.addr_sfx,	c.addr_sfx),
			r.parcel_id, r.segment_id, r.verify_code

	from		garland.nsa_code_inspect	c,
			garland.adrResult			r

	where		c.rowid			= i.rowid
	and		rtrim(c.case_number)	= r.rec_key
	and		r.verify_code > 0

	and		r.rec_seq = 
(
	select	max(rec_seq)
	from		garland.adrResult		
	where		rec_key = r.rec_key
)
);

--	================================================================================

	select * from explain_plan;
--	select * from explain_indexed;

--	Rollback;
	commit;
	alter rollback segment rb1	offline;

	select count(*) "NIS Inspect" from nsa_code_inspect;

--	analyze table	garland.NSA_CODE_INSPECT		compute statistics;

--	desc nsa_code_inspect;

--	================================================================================
	set echo	on;
	set timing	off;



