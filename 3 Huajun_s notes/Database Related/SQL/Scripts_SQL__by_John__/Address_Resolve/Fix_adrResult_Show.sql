
--	-----------------------------------------------------

--	select all *			from garland.adrResult_Input	r
--	select distinct addr_name	from garland.adrResult_Input	r

--	select all *			from garland.adrResult		r

	select distinct rpad(addr_name,20) "Padded Name" from garland.adrResult		r

--	-----------------------------------------------------

	where	verify_code < 10

	and	ltrim(addr_num, '0123456789 ') is null

--	-----------------------------------------------------

	and	exists
(
	select 'x'
	from	garland.adrStreets
	where	addr_name = rtrim(r.addr_name)
)


--	-----------------------------------------------------

	order by 1;

--	-----------------------------------------------------




