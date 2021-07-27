	set echo	off;
--	=======================================================
--	update empty parcel region using adrBlock
--	=======================================================
/*
	create or replace view		temp_view
(		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity,
		region_id
)
	as select
		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity,
		CODE_INSPECT_AREA
	from adrBlock_Side;
*/
--	=======================================================
--	update adrBlock_side region

--	@c:\deacutis\scripts\adrTable\bld_adrBlock_side_CODE.sq,		--	code inspect area

--	=======================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=======================================================

	update temp_view2		p

	set	region_id =
(
	select nvl(min(b.region_id), p.region_id)

	from	temp_view		b,
		cdreladr		a

	where	a.parcel_id	= p.parcel_id

	and	b.addr_name	= a.addr_name 
	and	b.addr_type	= a.addr_type 
	and	b.addr_pfx	= a.addr_pfx 
	and	b.addr_sfx	= a.addr_sfx
	
	and	b.addr_block  = trunc(a.addr_num,-2)
	and	b.addr_parity = mod  (a.addr_num, 2)
)
	where p.region_id is null;

	commit;

--	=======================================================

--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;



