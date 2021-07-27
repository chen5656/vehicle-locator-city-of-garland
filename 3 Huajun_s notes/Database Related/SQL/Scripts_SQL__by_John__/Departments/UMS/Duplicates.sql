	set echo	off;

	truncate table	plan_table;

--	=======================================================
--	account location summary

	explain plan	set statement_id = 'al1'		for

	select 'Account Location'				"table",
		 'acct - locn - seq'				" ",
		 count(distinct account_no)			"  selected",
		 1000							"  accounts",	--	sample	
		 round(sum(total)/count(*),1)			"   average",
		 count(total)					"     count",
		 sum  (total)					"       sum",
		 sum  (total) - count(total)			"     dupes"
	from
(
	select --+	driving_site (al)		index_desc (al)
			al.account_no,
			count(*)			total
	from		sfg.um00250t@umsrep.world		al
	,(
		select	account_no,
				location_no,
				min (service_seq)		service_seq
		from		sfg.um00250t@umsrep.world
		where		service_stat = 'CUTON'
		and		account_no < 1000						--	sample
		group by	account_no, location_no
	)							als
	
	where		al.account_no	= als.account_no
	and		al.location_no	= als.location_no
	and		al.service_seq	= als.service_seq
	and		al.service_stat = 'CUTON'
	and		al.account_no  <= 1000						--	sample
	group by	al.account_no, al.location_no, al.service_seq
	having	count(*) > 1
);

--	=======================================================
--	account location samples

	explain plan	set statement_id = 'al2'	for

	select	all *
	from		sfg.um00250t@umsrep.world
	where		service_stat = 'CUTON'
	and		(account_no, location_no, service_seq)	in
(
	select --+	driving_site (al)		index_desc (al)
			account_no, location_no, service_seq
	from		sfg.um00250t@umsrep.world		al

	where		service_stat = 'CUTON'
	and		account_no  <= 1000						--	sample
	group by	account_no, location_no, service_seq
	having	count(*) > 1
);

--	=======================================================
--	bill history summary

	explain plan	set statement_id = 'bh1'		for

	select 'Bill History'					"table",
		 'acct - date'					" ",
		 count(distinct account_no)			"  selected",
		 1000							"  accounts",	--	sample	
		 round(sum(total)/count(*),1)			"   average",
		 count(total)					"     count",
		 sum  (total)					"       sum",
		 sum  (total) - count(total)			"     dupes"
	from
(
	select --+	driving_site (bh)		index_desc (bh)
			account_no,
			count(*)			total
	from		sfg.um00260t@umsrep.world		bh

	where		audit_or_live = 'L'
	and		account_no <= 1000						--	sample
	group by	account_no, bill_run_dt
	having	count(*) > 1
);

--	=======================================================
--	bill history samples

	explain plan	set statement_id = 'bh2'	for

	select	all *
	from		sfg.um00260t@umsrep.world
	where		(account_no, bill_run_dt)	in
(
	select --+	driving_site (bh)		index_desc (bh)
			account_no, bill_run_dt
	from		sfg.um00260t@umsrep.world		bh

	where		audit_or_live = 'L'
	and		account_no < 100							--	sample
	group by	account_no, bill_run_dt 
	having	count(*) > 1
);

--	=======================================================
--	bill detail summary

	explain plan	set statement_id = 'bd1'		for

	select 'Bill Detail'					"table",
		 'acct - locn - seq - date'			" ",
		 count(distinct account_no)			"  selected",
		 1000							"  accounts",	--	sample	
		 round(sum(total)/count(*),1)			"   average",
		 count(total)					"     count",
		 sum  (total)					"       sum",
		 sum  (total) - count(total)			"     dupes"
	from
(
	select --+	driving_site (bd)		index_desc (bd)
			account_no,
			count(*)			total
	from		sfg.um00261t@umsrep.world		bd

	where		account_no <= 1000						--	sample
	group by	account_no, location_no, service_seq, bill_run_dt
	having	count(*) > 1
);

--	=======================================================
--	bill detail samples

	explain plan	set statement_id = 'bd2'		for

	select	all *
	from		sfg.um00261t@umsrep.world
	where		(account_no, location_no, service_seq, bill_run_dt )	in
(
	select --+	driving_site (bd)		index_desc (bd)
			account_no, location_no, service_seq, bill_run_dt 
	from		sfg.um00261t@umsrep.world		bd

	where		account_no < 10							--	sample
	group by	account_no, location_no, service_seq, bill_run_dt 
	having	count(*) > 1
);

--	=======================================================
	select * from explain_plan;

	set echo on;
