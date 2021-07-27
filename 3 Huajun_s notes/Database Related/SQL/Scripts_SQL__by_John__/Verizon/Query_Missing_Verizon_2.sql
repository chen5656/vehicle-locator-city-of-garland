	set echo 		off;
	set fetchrows;
--	===========================================================

--	desc garland.verizon_info;
--	desc gis.address;

--	===========================================================
/*

	select xcoord ||','|| ycoord
--	select *		from
--	select count(*)	from

--	select count(*)

	from	sde.address_gis_default
	where	(streetname, streetnum||'') 
	in
(
	select streetname, streetnum||''
	from	sde.address_gis_default

	minus

	select streetname, streetnum
	from garland.verizon_info 
)
--	order by 1,2
	;

*/
--	===========================================================
/*

	select * from garland.adrResult_Verizon
	where appl_name like '%ARBOR%'
	;

*/
--	===========================================================

	set termout off;
	spool c:\deacutis\extract\missing_from_verizon.txt

	select xcoord ||','|| ycoord
--	select *		from
--	select count(*)	from

--	select count(*)

	from	sde.address_gis_default
	where	(streetname, streetnum||'') 
	in
(
	select streetname, streetnum||''
	from	sde.address_gis_default

	minus

	select streetname, streetnum
	from garland.verizon_info 
)
--	order by 1,2
	;


	spool off


--	===========================================================
	set fetchrows;
	set termout 	on;
