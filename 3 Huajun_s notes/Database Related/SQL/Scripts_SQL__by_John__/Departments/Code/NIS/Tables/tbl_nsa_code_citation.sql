
	drop table		nsa_code_citation;
	create table	nsa_code_citation
(
	case_number			number,
	citation_number		number,
	citation_issue_date	date,
	citation_comply_date	date
)
	tablespace		gis_data
	storage		(initial 320k  next 320k  pctincrease 0);

--	-------------------------------------------------------------------------------------

	alter table		nsa_code_citation		add
	constraint		nsa_code_citation_pkey
				primary key (case_number, citation_number)
	using index
	tablespace		gisindx
	storage		(initial 320k  next 320k  pctincrease 0);

--	=====================================================================================
--	=====================================================================================
/*

	select * from all_tab_columns@cdep.world
	where table_name = 'CITATION';

	select count(*) from citation@cdep.world		--	5085
	where case_number in
(
	select case_number from citation@cdep.world	
	intersect
	select case_number from inspection@cdep.world	
);


	select count(*) 						--	0
	from inspection@cdep.world
	where citation_number > '0';

*/
--	=====================================================================================

