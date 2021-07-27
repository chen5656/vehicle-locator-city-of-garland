	set echo		off;
	set timing		on;
	set fetchrows	111;

--	========================================================================================
/*	TEMPLATES

--	create public database link 	umsrep.world		using 'umsrep';

	select * from sfg.um00100m@umsrep.world		where rownum < 111;

	select * from all_tables@umsrep.world			where rownum < 11 and owner like 'SFG%';
	select table_name, column_name			from all_tab_columns@umsrep.world where owner = 'SFG';

	select table_name, column_name
	from	 all_tab_columns@umsrep.world
	where	 owner = 'SFG'
	and	 table_name = 	'SG00130T'
--	and	 table_name like 	'UM0025%'
	;

	select table_name, column_name  from all_tab_columns@umsrep.world  where owner = 'SFG'
	and	table_name = 'UM00260T';

	select *
	from sfg.um00260t@umsrep.world
	where account_no	in  (11, 12)
	and	bill_run_dt > to_date('01JAN00', 'ddmonyy')
	and	audit_or_live = 'L'
	order by	account_no, bill_run_dt;

--	========================================================================================

	select count(count(*)) 							--	one-many relations
	from sfg.um00250t@umsrep.world
	group by 	location_no
	having	count(distinct account_no) > 1;

	select count(*) 				"250t"			--	496100
	from	sfg.um00250t@umsrep.world;

	select count(distinct account_no)	"250t acct"			--	105240
	from	sfg.um00250t@umsrep.world;
	select min(account_no) "min", max(account_no) "max"	
	from	sfg.um00250t@umsrep.world;

	select count(distinct location_no)	"250t locn"			--	79270		acct/locn
	from	sfg.um00250t@umsrep.world;
	select min(location_no) "min", max(location_no) "max"	
	from	sfg.um00250t@umsrep.world;


	select count(distinct location_no)	"100m locn"			--	82640		locn
	from	sfg.um00100m@umsrep.world;
	select min(location_no) "min", max(location_no) "max"	
	from	sfg.um00100m@umsrep.world;

--	========================================================================================
--	list table names with specific combination of fields

	select '''' ||  table_name || ''','		table_name
	from	 all_tables@umsrep.world		t
	where	 owner = 'SFG'

	and exists 
	(	select 'x'
		from all_tab_columns@umsrep.world
		where	table_name	= t.table_name
		and	column_name = 'LOCATION_NO'	)
	and exists 
	(	select 'x'
		from all_tab_columns@umsrep.world
		where	table_name	= t.table_name
		and	column_name like 'STREET%'	)
	;

--	========================================================================================
--	billing header may have multiple records for account_no, bill_run_dt
--	billing detail may have multiple records for account_no, location_no, service_no, bill_run_dt

	select count(total)				"count",
		 sum(total)					"sum",
		 sum(total) - count(total)		"dupes"
	from
(
	select --+	driving_site (bh)		index_desc (bh)
			count(*)				total
	from		sfg.um00260t@umsrep.world		bh
	where		audit_or_live = 'L'
--	and		account_no < 1000						--	sample
	group by	account_no, bill_run_dt
	having	count(*) > 1
);


	select count(total)				"count",
		 sum(total)					"sum",
		 sum(total) - count(total)		"dupes"
	from
(
	select --+	driving_site (bd)		index_desc (bd)
			count(*)				total
	from		sfg.um00261t@umsrep.world		bd
	where		account_no < 100						--	sample
	group by	account_no, location_no, service_seq, bill_run_dt
	having	count(*) > 1
);

*/
--	========================================================================================

--	set timing off;	
--	truncate table	plan_table;
--	explain plan	set statement_id = 'stat'	for

--	-------------------------------------------------------------------------------

	select	count(*) " "					--	3782

	from		 sfg.um00250t@umsrep.world	al		--	account location
			,sfg.um00100m@umsrep.world	ul		--	utility location
			,sfg.um00260t@umsrep.world	bh		--	utility bill header

	where		al.account_no	between 01	and 100	--	specify ACCOUNT RANGE
	and		al.location_no	= ul.location_no
	and		al.account_no	= bh.account_no

	and not	(
			nvl(ul.house_no, ' ')			= nvl(bh.house_no, ' ')
		and	nvl(ul.street_nm,' ')			= nvl(bh.street_nm,' ')
		and	nvl(ul.street_nm_sfx,' ')		= nvl(bh.street_nm_sfx,' ')
		and	nvl(ul.street_pfx_dir,' ')		= nvl(bh.street_pfx_dir,' ')
		and	nvl(ul.street_sfx_dir,' ')		= nvl(bh.street_sfx_dir,' ')
			)

	and		bh.audit_or_live	= 'L'
	and		al.cutoff_dt	is null

--	group by	bd.account_no, bd.location_no, bd.service_seq, bd.bill_run_dt
--	having	count(*) > 1
	;

--	-------------------------------------------------------------------------------

--	select * from explain_plan;

--	========================================================================================
	
	set echo		on;
	set fetchrows;

