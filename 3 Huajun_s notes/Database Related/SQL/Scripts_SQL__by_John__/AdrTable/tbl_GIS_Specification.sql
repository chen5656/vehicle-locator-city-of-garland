	set echo	off;
--	================================================================

--	drop table		garland.GIS_Specification;

	create table	garland.GIS_Specification
(
	spec01		varchar2(40),
	spec02		varchar2(40),
	spec03		varchar2(40),
	spec04		varchar2(40),
	spec05		varchar2(40),
	spec06		varchar2(40),
	spec07		varchar2(40),
	spec08		varchar2(40),
	spec09		varchar2(40),
	spec10		varchar2(40)
)
	tablespace		gis_data
	storage		(initial 20k  next 20k  pctincrease 0);

--	================================================================

	create table	garland.GIS_Specification
		on		garland.GIS_Specification (spec01)

	tablespace		gisindx
	storage		(initial 20k  next 20k  pctincrease 0);

--	================================================================
	set echo	on;
