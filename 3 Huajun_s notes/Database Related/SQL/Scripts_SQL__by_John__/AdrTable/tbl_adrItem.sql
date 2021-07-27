
--	adrItem table contains standard address elements
--	"Item" field contains either standard or possible spelling

	drop table		adrItem;

	create table	adrItem
(
	class			varchar2(01),		--	street directional(D), street type(T), or unit type(U)
	possible		varchar2(20),		--	possible spelling			(eg LA)
	standard		varchar2(05),		--	standard address item		(eg LN)
	name			varchar2(20)		--	full name				(eg LANE)
)

	tablespace		gis_data
	storage		(initial 320k  next 320k  pctincrease 0)
	pctfree  01		pctused 99
	;


