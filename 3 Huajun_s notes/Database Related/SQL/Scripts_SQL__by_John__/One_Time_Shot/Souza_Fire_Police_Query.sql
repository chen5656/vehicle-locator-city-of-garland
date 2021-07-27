--	=====================================================================
set echo		off
set timing		off
set sqlblanklines	on
set serveroutput	on	size 99999
set linesize	2000
set pagesize	9999
--	=====================================================================


	select 
		rpad(app,10) app,
		rpad(num,20) num, rpad(pfx,20) pfx, rpad(name,20) name, rpad(typ,20) type, rpad(sfx,20) sfx, 
		rpad(bldg,20) bldg, rpad(unit,20) unit 

	from	garland.Temp_View
	where	app	= 'POLICE'
	and	name	= 'BARNES'

	and	rownum < 111

	order by name, typ, pfx, sfx, num;

--	=====================================================================

--	select count(*) from garland.temp_view where app = 'FIRE';
--	select count(*) from garland.temp_view where app = 'POLICE';

--	=====================================================================

