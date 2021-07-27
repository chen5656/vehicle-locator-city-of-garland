	set echo off;
--	=======================================================================
--	show address info from WMS SQL SERVER database
--	=======================================================================

	create or replace view  garland.WMS_Address_View
(
	id,
	streetnum, streetprefix, streetname, streettype, streetlabel, 
	zone, meter,basin,
	Banner, UMS, Grid, mappage,
	pipe_id, sewer, water, streetsuffix
)

	as	select * from tbl_addresslist@gwater;	

