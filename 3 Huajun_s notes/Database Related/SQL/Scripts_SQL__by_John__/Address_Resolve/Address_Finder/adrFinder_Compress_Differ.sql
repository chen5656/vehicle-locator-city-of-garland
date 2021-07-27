	set echo	off;
	set timing	on;
--	==================================================================

--	truncate table	plan_table	reuse storage;
--	explain plan	set statement_id = 'xxx'		for


--	select	count(*)



	select	distinct 

			rpad (
			nvl (length (translate (a.addr_compress,  'x'||b.addr_compress, 'x')), 0)	+
			nvl (length (translate (b.addr_compress,  'x'||a.addr_compress, 'x')), 0)
			, 05) " ",

			rpad(a.addr_name,15) " ", rpad(a.addr_begin,15) " ", rpad(a.addr_ending,15) " ",
			rpad(b.addr_name,15) " ", rpad(b.addr_begin,15) " ", rpad(b.addr_ending,15) " "




	from		adrStreets		a,
			adrStreets		b


	where		a.addr_name <> b.addr_name


	and	(	nvl (length (translate (a.addr_compress,  'x'||b.addr_compress, 'x')), 0)	+
			nvl (length (translate (b.addr_compress,  'x'||a.addr_compress, 'x')), 0)	<= 1

	or		a.addr_name	like nvl(b.addr_begin,'/') || '%'
	or		b.addr_name	like nvl(a.addr_begin,'/') || '%'


	or		a.addr_name	like '%' || nvl(b.addr_ending,'/') 
	or		b.addr_name	like '%' || nvl(a.addr_ending,'/') 

		)


--	and		a.addr_name	like 'C%'
--	and		b.addr_name	like 'C%'


	and		a.addr_name	= 'COUNTRY CLUB'


	order by

--			nvl (length (translate (a.addr_compress,  'x'||b.addr_compress, 'x')), 0)	+
--			nvl (length (translate (b.addr_compress,  'x'||a.addr_compress, 'x')), 0),
		
			rpad(a.addr_name,15)
			;



--	select * from explain_plan;


--	==================================================================
	set echo	on;
	set timing	off;


