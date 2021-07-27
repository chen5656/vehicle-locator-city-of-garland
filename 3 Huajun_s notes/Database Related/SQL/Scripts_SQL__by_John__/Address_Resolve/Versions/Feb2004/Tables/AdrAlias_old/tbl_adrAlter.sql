
--	after "gis_address_resolve" is run
--	execute scripts beginning with "77_"  to produce ascii templates for user specified alterations
--	then sql*load the ascii file into adrAlter
--	execute "66_load_alien_alias" to populate adrAlien & adrAlias from adrAlter

	drop table		garland.adrAlter;

	create table	garland.adrAlter
(	

	flag1			varchar2(05),
	pfx1			varchar2(10),
	name1			varchar2(40),
	type1			varchar2(10),
	sfx1			varchar2(10),

	flag2			varchar2(05),
	pfx2			varchar2(10),
	name2			varchar2(40),
	type2			varchar2(10),
	sfx2			varchar2(10),

	flag3			varchar2(05),
	pfx3			varchar2(10),
	name3			varchar2(40),
	type3			varchar2(10),
	sfx3			varchar2(10),

	lo_range		varchar2(06),
	hi_range		varchar2(06),
	notes			varchar2(40)

)

	tablespace		gis_data
	storage		( initial 320k  next 320k  pctincrease 0 );

		
