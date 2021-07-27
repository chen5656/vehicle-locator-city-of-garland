	set echo off;
--	================================================================================
--	correct application street names based on a "reduced name" match w/ adrStreets
--	================================================================================

	drop	 synonym tmp_table_syn;
	create synonym tmp_table_syn		for PAVEMENT_MASTER;		--	application table
--	=======================================================

	alter rollback segment rb1		 online;
	commit;
	set transaction use rollback segment rb1;

--	=======================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	update	tmp_table_syn	t					--	update only
	set		addr_name =

(
	select 
	distinct									--	update
	 	 s.addr_name		"GIS Street Name"
--		,t.addr_name		"APP Street Name"			--	display only

	from
		 adrStreets			s
--		,tmp_table_syn		t					--	display only
	
	where		s.addr_reduced = adr_compress_name (t.addr_name, 1)
	and		s.addr_name	<> t.addr_name
)


	where exists								--	update only
(
	select 'x'
	from	 adrStreet	
	where	 addr_reduced = adr_compress_name (t.addr_name, 1)
	and	 addr_name	 <> t.addr_name
)

--	order by	1,2								--	display only

;

--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	=======================================================

	rollback;
--	commit;
	alter rollback segment rb1		 offline;


/*
--	=======================================================
--	display duplicate reduced names

--	select	parcel_id, addr_num, addr_pfx, addr_name, addr_sfx
--	from		cdreladr
--	select	mslink, addr_lo, addr_pfx, addr_name, addr_sfx
--	from		trvehrcl
--	where		addr_name	in

(
	select	distinct
			 addr_name
--			,addr_reduced	
	from		adrStreets
	where		addr_reduced in
(
	select	addr_reduced
	from		adrStreets
	group by	addr_reduced
	having	count(distinct addr_name) > 1
))

--	order by	addr_name, addr_type, addr_pfx, addr_sfx

;
--	=======================================================
*/

	set echo on;
