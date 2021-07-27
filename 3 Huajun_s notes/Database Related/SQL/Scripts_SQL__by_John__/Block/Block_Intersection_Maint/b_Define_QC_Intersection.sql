--	DEFINE QC INTERSECTION


	set echo off;
--	==========================================================================
--	Define view of Intersection key on a temporary table
--	This allows QC of Intersection modifications before they are applied
--	==========================================================================

	create or replace view		garland.Temp_View
(
	intersect_id,

	addr1_block,
	addr1_pfx,
	addr1_name,
	addr1_type,
	addr1_sfx,

	addr2_block,
	addr2_pfx,
	addr2_name,
	addr2_type,
	addr2_sfx,

	road1_id,
	road2_id,
	side1,
	side2,
	row_id
)
	as

	select	item01, 
			item02, item03, item04, item05, item06,
			item07, item08, item09, item10, item11,
			item12, item13, item14, item15, item16
	from		garland.gis_objects;

--	==========================================================================
	set echo on;
