

--	test the validity of the extract
--	can you find a record w/out a bad number	

	select count(*) from
(
	select 'x' from gis_temp4

	where	exists
(
	select 'x'
	from	 cdreladr
	where	 addr_name = item01
	and	 addr_num  = to_number(item02)
)
	and	exists
(
	select 'x'
	from	 cdreladr
	where	 addr_name = item03
	and	 addr_num  = to_number(item02)
)

);



