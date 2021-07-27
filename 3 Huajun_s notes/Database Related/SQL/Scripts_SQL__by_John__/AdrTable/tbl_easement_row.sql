
--	drop table		garland.EASEMENT_ROW;				--	change

	Create table	garland.EASEMENT_ROW				--	change
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	subdivision			varchar2(40),
	block				varchar2(05),
	lot1				varchar2(03),
	lot2				varchar2(03),
	lot3				varchar2(03),
	lot4				varchar2(03),

	easement_type		varchar2(25),
	easement_size		varchar2(12),

	separate_instrument	varchar2(10),

	volume			number,
	page				number
)
	nologging
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	========================================================================

	alter table		garland.easement_ROW				--	change
	add
(
	constraint	easement_ROW_mslink					--	change
	unique	(mslink)

	using	index
	tablespace	gisindx
	storage 	(initial 50k next 50k  pctincrease 0)
);

--	===============================================================

