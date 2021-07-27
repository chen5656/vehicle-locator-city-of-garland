	set echo off;
--	==================================================================
--	Does GIS + TAX have both Zero & Non_Zero UMS keys :
--	==================================================================

	select * from
(
	select gis_key, tax_key,  min(ums_key) min_ums, max(ums_key) max_umn, count(*)
	from	garland.COMMON_RECORD_SEQ
	group by gis_key, tax_key
	having count(*) > 1

)
	where	min_ums = 0
	and	rownum < 111;

