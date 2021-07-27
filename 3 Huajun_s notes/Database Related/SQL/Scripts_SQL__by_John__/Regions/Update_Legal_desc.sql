--	========================================================================

	alter rollback segment RB1 online;
	commit;
	set transaction use rollback segment RB1;

--	========================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	update garland.NSA_CRIME		c			-- CHANGE
	set	( LEGAL1, LEGAL2 ) = 					-- CHANGE

	(	select	lgl1_desc, lgl2_desc
		from		garland.nsa_dcad_res
		where		rowid = 
		(	select	min (rowid)	
			from		garland.nsa_dcad_res	t
			where		t.parcel_id = c.parcel_id	
		)
	)
	where	c.parcel_id > '00';


--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;

--	========================================================================

	commit;
	alter rollback segment RB1 offline;

--	========================================================================


