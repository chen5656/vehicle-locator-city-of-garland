
--	desc tax;
--	analyze table	tax		compute statistics;

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'xxx'		for


	select	-- use_hash (u)

			' GIS   ', rpad(a.addr_id,18), 
			'     ',
				rpad(a.addr_num, 10), 
				rpad(a.addr_pfx, 09),
				rpad(a.addr_name,40), 
				rpad(a.addr_type,05), 
				rpad(a.addr_sfx, 05),
				chr(10),

			'UMS   ', rpad(u.location_no,20), 
			u.house_no, u.street_pfx_dir, u.street_nm, 
			u.street_nm_sfx, u.street_sfx_dir, chr(10),

			'TAX   ', ltrim(t.macctno), 
			t.propaddr, chr(10)

	from		cdreladr				a,
			tax					t,
			sfg.um00100m@umsp.world		u

	where		t.macctno	  (+)		= lpad(a.tax_key,25)	
	and		u.location_no (+)		= a.ums_key	

	and		a.addr_id between 1 and 100		--	specify range
	
	order by	a.addr_id;


--	select * from explain_plan;

