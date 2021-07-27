
--	adrEnding contains names found at the end of street names


--	drop table		adrEnding;

	create table	adrEnding
(
	name			varchar2(10),		
	name_tail		varchar2(03)		
)

	tablespace		gis_data
	storage		(initial 320k  next 320k  pctincrease 0)
	pctfree  01		pctused 99
	;



