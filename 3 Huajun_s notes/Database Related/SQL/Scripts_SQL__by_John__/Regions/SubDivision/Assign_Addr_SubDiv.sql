	set echo	off;
	set timing	off;
--	====================================================================

--	ASSIGN SUBDIVISION ID TO APP TABLE
--	THE TABLE HAS BEEN PREVIOUSLY VERIFIED AND ASSIGNED A PARCEL ID (ADDRESS RESOLVE SERIES)

--	====================================================================
/*

	select	count (count(*) )		--  none found
	from		cdrelpar
	where		subdiv_id > ' '
	group by	parcel_id
	having 	count ( distinct subdiv_id ) > 1;

*/
--	====================================================================

	drop synonym	garland.tmp_table_syn;

	create synonym	garland.tmp_table_syn	for garland.NSA_CRIME;

--	====================================================================

	alter rollback segment RB1 online;
	commit;
	set transaction use rollback segment RB1;

	set timing	on;
--	====================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'subdiv'		for

	update	garland.tmp_table_syn		u
	set		u.subdiv_id = 
		(
			select	distinct 
					subdiv_id
			from		cdrelpar	p
			where		p.subdiv_id > '0'
			and		p.parcel_id = u.parcel_id
		);

--	select * from explain_plan;

--	====================================================================

	Rollback;
	commit;

	set timing off;

	alter rollback segment RB1 offline;

--	====================================================================
