
	drop table		trvehrcl_audit;

	create table	trvehrcl_audit	
(
	person			varchar2(08),
	action			varchar2(01),
	timestamp			date,

	mslink_bef			number,
	mslink_aft			number,
	branch_bef			number,
	branch_aft			number,
	section_bef			number,
	section_aft			number,

	pfx_bef			varchar2(02),
	pfx_aft			varchar2(02),
	name_bef			varchar2(35),
	name_aft			varchar2(35),
	type_bef			varchar2(0),
	type_aft			varchar2(04),
	sfx_bef			varchar2(02),
	sfx_aft			varchar2(02),

	lo_bef			number,
	lo_aft			number,
	hi_bef			number,
	hi_aft			number
)
	tablespace	gis_data
	storage	(initial 1m   next 320k  pctincrease 0);


