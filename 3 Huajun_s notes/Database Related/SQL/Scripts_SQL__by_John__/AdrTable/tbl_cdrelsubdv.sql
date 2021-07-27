	set echo	off;
--	=====================================================

--	drop table		garland.cdrelsubdv;

	create table	garland.cdrelsubdv
(
	mslink		number	not null,    
	mapid			number,    

	subdiv_id		number	not null,

	final_plat		varchar2(40),
	replat		varchar2(40),

	block			varchar2(05),
	lot_lo		varchar2(05),
	lot_hi		varchar2(05),

	resident_lots	number,
	common_lots		number,

	volume		number,
	page_no		number,

	area_sqft		number,
	area_acre		number,

	filing_date		varchar2(10),
	login_date		varchar2(07),

	parcel1		number,
	parcel2		number,
	parcel3		number,
	parcel4		number,

	grid1			varchar2(3),
	grid2			varchar2(3),
	grid3			varchar2(3),
	grid4			varchar2(3),

	constraint cdrelsubdv_unq_subdiv
	unique		(subdiv_id)
	using index
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0),

	constraint cdrelsubdv_unq_mslink
	unique		(mslink)
	using index
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0)
)
	
	tablespace		gis_data
	storage		(initial 1m  next 1m  pctincrease 0)
;

--	=====================================================
	set echo	on;
