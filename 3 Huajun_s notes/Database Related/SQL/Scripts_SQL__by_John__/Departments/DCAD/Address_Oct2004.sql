--	==============================================================================================
--	DCAD Address extract
--	==============================================================================================

--	==============================================================================================
--	"Acct_1","Gisacct","Stcitycode","Stname","Sttype","Stdir","Stnumber","Sthalf","Condounit"
--	==============================================================================================

	create or replace view	garland.Temp_View
(
	dcad_id,
	geoacct,
	city,
	addr_name,
	addr_type,
	addr_pfx,
	addr_num,
	addr_unit1,
	addr_unit2
)
	as	select item01, item02, item03, item04, item05, item06, item07, item08, item09
		from	 garland.GIS_Objects; 


