	set echo off;

--	==============================================================
--	compare soundex results with Type B & C results

	select r.do_name " ",	rpad(r.form_name,20) "accept B & C", 
					rpad(r.addr_name,20) " "

	from	adrResult	r,
		adrStreet	s

	where	r.addr_name	= s.addr_name (+)
	and	r.do_name in ( 'B', 'C' )

	and	soundex (r.form_name) in
	(
		select	addr_soundex
		from		adrStreet
		group by	addr_soundex
		having	count(*) = 1
	)

	order by	r.do_name, r.addr_name;

--	==============================================================
--	which fuzzy name errors would soundex filter out

	select distinct r.do_name " ",	rpad(r.form_name,20) "reject B & C", 
							rpad(r.addr_name,20) " "
	from	adrResult	r,
		adrStreet	s

	where	r.do_name  in ('B', 'C')
	and not exists
(
	select 'x'
	from	adrStreet	s
	where	soundex (r.form_name) = s.addr_soundex
	group by s.addr_soundex
	having count(*) = 1
);

--	==============================================================
--	==============================================================
--	compare soundex results with non-garland results

	select r.do_name " ",	rpad(r.form_name,20)  "accept non-garland", 
					s.addr_name " "

	from	adrResult	r,
		adrStreet	s

	where	r.verify_code = 1
	and	soundex(r.addr_name) = s.addr_soundex
	and	exists
	(
		select	addr_soundex
		from		adrStreet
		where		addr_soundex = soundex(r.addr_name)
		group by	addr_soundex
		having	count(*) = 1
	)

	order by	r.do_name, r.addr_name;

--	==============================================================
--	compare soundex results with non-garland results

	select distinct 
		rpad(r.form_name,20)  "reject non-garland" 

	from	adrResult	r,
		adrAlias	a

 	where	verify_code = 1
	and	r.form_name	= a.alias_name
	and	a.alias_how like '%$'
	and	not exists
	(
		select	addr_soundex
		from		adrStreet
		where		addr_soundex = soundex(r.addr_name)
		group by	addr_soundex
		having	count(*) = 1
	);

--	==============================================================
