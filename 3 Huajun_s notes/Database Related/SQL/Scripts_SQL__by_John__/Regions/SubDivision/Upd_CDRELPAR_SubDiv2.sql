
--	UPDATE CDRELPAR SUBDIVISION IDS FOR DUPLICATE CDRELTAX PARCEL_IDS	HAVING A UNIQUE SUBDIVISION ID

	
	set timing on;

/*	

--	table of duplicate parcel ids in cdreltax having a unique subdivision id

	drop table		tmp_dupe_tax_subdiv_parcel;

	create table	tmp_dupe_tax_subdiv_parcel		as		

		select 	t.parcel_id
		from 		cdreltax				t,
				tmp_dupe_tax_parcel_ids		d
		where		t.parcel_id = d.parcel_id
		group by	t.parcel_id		
		having	count ( distinct substr (t.dist_account, 03, 05) ) = 1;	


	analyze table	tmp_dupe_tax_subdiv_parcel	compute statistics;
*/


--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	update cdrelpar	p
	set	p.subdiv_id = 	
		(	select distinct 
				substr (dist_account, 03, 05)
			from	cdreltax	t
			where	t.parcel_id = p.parcel_id
			
		)
	where	p.parcel_id in
		(	select parcel_id
			from	 tmp_dupe_tax_subdiv_parcel
		)
	;
	

--	@c:\deacutis\scripts\plans\exhibit.sql
			

	commit;

	set timing off;
	
