	set echo		off;
--	======================================================================
--	update adrResult segment id = dcad account number
--	======================================================================

	alter rollback segment rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'xxx'	for

	update  garland.adrResult	r
	set	segment_id = 
(
	select	min(acct)
	from		garland.nsa_dcad_res
	where		parcel_id	= r.parcel_id
	and		street_nam	= r.addr_name
	and		street_typ	= r.addr_type
	and		street_dir	= r.addr_pfx
	and		street_sfx	= r.addr_sfx
	and		street_num	= r.addr_num
	and		r.verify_code = 55
);

--	select * from explain_plan;
--	select * from explain_indexed;

	commit;
	alter rollback segment rb1		offline;


--	======================================================================

	select count(segment_id)  from garland.adrResult;

--	======================================================================
/*

	select parcel_id, street_num, street_dir, street_nam, street_typ, acct
	from nsa_dcad_res
	where	parcel_id in
(
	select parcel_id
	from 		nsa_dcad_res
	group by	parcel_id
	having	count(*) > 1
)
	order by 1;

*/
--	======================================================================
	set echo		on;
