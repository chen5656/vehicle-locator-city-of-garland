
--	source:	Access table from Daniel Nigo
--	needs:	Formatted Address + Parcel ID

	drop table		flooding;

	create table	flooding
	(
		item_01		varchar2(40),
		item_02		varchar2(40),
		item_03		varchar2(40),
		item_04		varchar2(50),		--	priority
		item_05		varchar2(40),
		item_06		varchar2(40),
		item_07		varchar2(40),
		item_08		varchar2(40),
		item_09		varchar2(70),		--	remedy
		item_10		varchar2(40),
		item_11		varchar2(40),
		item_12		varchar2(70),		--	special
		item_13		varchar2(40),
		item_14		varchar2(40),
		item_15		varchar2(40),
		item_16		varchar2(40),
		item_17		varchar2(40),
		item_18		varchar2(40),
		item_19		varchar2(40),
		item_20		varchar2(40),
		item_21		varchar2(80),		--	town
		item_22		varchar2(70),		--	remarks
		item_23		varchar2(40),
		item_24		varchar2(40),
		item_25		varchar2(40),
		item_26		varchar2(40),

		addr_num		varchar2(05),
		addr_pfx		varchar2(02),
		addr_name		varchar2(40),
		addr_type		varchar2(04),
		addr_sfx		varchar2(02),
		addr_apt		varchar2(10),
		parcel_id		varchar2(12)
	)
		
		tablespace	gis_data
		storage ( initial 1m  next 1m  pctincrease 0 );



--	create unique index	flooding_x_item0103
--		on			flooding  (item_01, item_02, item_03)
--		tablespace		gisindx
--		storage	( initial 1m  next 1m  pctincrease 0 );
