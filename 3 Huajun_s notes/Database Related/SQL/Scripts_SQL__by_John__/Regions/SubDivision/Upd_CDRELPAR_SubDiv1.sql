
--	UPDATE CDRELPAR SUBDIVISION ID
--	MATCH PARCEL_ID AGAINST CDRELTAX
--	CDRELTAX CONTAINS SUBDIVISION_ID AS BYTES 03-07 IN DIST_ACCOUNT


	set timing on;

/*	STATISTICAL QUERIES

	select count(*) from cdreltax where nvl(parcel_id, 0) = 0;	-- 5247

--	what parcel ids on cdrelpar do not exist on cdreltax		-- 7304
	select	parcel_id
	from		cdrelpar
	where		nvl (subdiv_id, 0) = 0
	minus
	select	parcel_id
	from		cdreltax;

	select	count(*)							-- 62200
	from		cdreltax
	where		NVL (supp_num, ' ') < '0';	

--	which cdrelpar parcel_ids do not match cdreltax parcel_ids  -- (7350)
	select	parcel_id	from 	cdrelpar
	minus
	select	parcel_id
	from		cdreltax
	where		NVL (supp_num, ' ') < '0';

*/


/*

--	table of all duplicate parcel ids in cdreltax
	drop table		tmp_dupe_tax_parcel_ids;
	create table	tmp_dupe_tax_parcel_ids		as		-- (304)
		select	parcel_id
		from		cdreltax
		where		nvl (supp_num, ' ') < '0'		-- ignore apartment duplicates
		group by 	parcel_id
		having 	count(*) > 1;

	analyze table	tmp_dupe_tax_parcel_ids		compute statistics;

*/	

	alter rollback segment RB_LARGE online;
	set transaction use rollback segment RB_LARGE;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for	

	update cdrelpar	p
	set subdiv_id	=
	
	(	select	substr (dist_account, 03, 05)
		from		cdreltax	t
		where		nvl (supp_num, ' ') < '0'		-- ignore apartment duplicates
		and		t.parcel_id = p.parcel_id
	)

	where	p.parcel_id	 in	
	(	select parcel_id from cdrelpar
		minus
		select parcel_id from tmp_dupe_tax_parcel_ids	
	)
	;

--	@c:\deacutis\scripts\plans\exhibit.sql

	commit;

	alter rollback segment RB_LARGE offline;

	set timing off;

