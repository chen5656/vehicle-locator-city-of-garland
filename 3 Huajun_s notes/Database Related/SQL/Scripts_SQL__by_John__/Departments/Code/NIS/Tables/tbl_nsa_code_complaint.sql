
	drop table		nsa_code_complaint;
	create table	nsa_code_complaint
(
	case_number		number
)
	tablespace		gis_data
	storage		(initial 320k  next 320k  pctincrease 0);

--	-------------------------------------------------------------------------------------

	alter table		nsa_code_complaint	add
	constraint		nsa_code_complaint_pkey
				primary key (case_number)
	using index
	tablespace		gisindx
	storage		(initial 320k  next 320k  pctincrease 0);

--	=====================================================================================
--	=====================================================================================
/*

	select * from all_tab_columns@cdep.world
	where table_name = 'COMPLAINT';

	select count(*) from complaint@cdep.world		--	9585
	where case_number in
(
	select case_number from complaint@cdep.world	
	intersect
	select case_number from inspection@cdep.world	
);


	select count(*) 						--	9601
	from inspection@cdep.world
	where complaint_number > '0';

*/
--	=====================================================================================
