	set echo	off;

--	===============================================================================================
/*

--	table size
	select count(*) "table size" from dbo.adr_base@pt01.world;

--	record sample
	select * 
	from	dbo.adr_base@pt01.world
	where	rownum < 11;



--	index columns
	select table_name, index_name, rpad(column_name,30) "COLUMN_NAME"
	from	all_ind_columns@pt01.world
	where	table_name = 'PAR_BASE'
	order by index_name, column_position;


--	column domain
	select distinct
	type_class
	from	dbo.adr_base@pt01.world;


--	===============================================================================================


--	Par_Base = Adr_Base			non-matching keys

	select  element_key
	from	dbo.Par_Base@pt01.world
	intersect
	select  element_key
	from	dbo.Adr_Base@pt01.world;

*/
--	===============================================================================================

--	=====================================================
/*

	select	*

	from		dbo.APD_ITMS@pt01.world	

	where 	rownum < 111;


*/
--	=====================================================
/*

--	select	data_level,
--			entered_date, date_a, date_b, date_c, date_d

	select	entered_date, count(*)

	from		dbo.apd_base@pt01.world	

--	where		date_d is not null

	group by	entered_date

--	and		rownum < 11
	;

*/
--	=====================================================
/*

	select	table_name, column_name
	from		all_tab_columns@pt01.world	

--	where		table_name = 'TAB_ACT'

--	where		column_name like '%ACTION%'

	where		data_type = 'DATE'
	and		rtrim(column_name,'0123456789') = column_name

	and		owner = 'DBO'
	;

*/
--	=====================================================
/*
	select	number_key, count(*)
	
	from		dbo.apd_adr@pt01.world	

	where		data_level = 'A'

	group by	number_key
	having	count(distinct site_element_key) > 1

	;
*/
--	=====================================================
	set echo	on;
