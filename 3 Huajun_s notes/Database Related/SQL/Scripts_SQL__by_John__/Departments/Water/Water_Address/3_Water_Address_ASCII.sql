	set	echo		off;
	set	timing	on;
--	===========================================================================
	set 	termout	OFF;			--	<<<<<<<<<<<<
--	===========================================================================

	spool  c:\deacutis\extract\WATER_ADDRESS.txt;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

--	select count(*)	from 
	
	select 'num,pre,street,type,suf,loc#,wtrid,grid,mapsco,zone,basin,council,fire' " " from dual
	union all

	select * from
(
	select
		addr_num			||','||
		nvl(addr_pfx, ' ')	||','||
		nvl(addr_name,' ')	||','||
		nvl(addr_type,' ')	||','||
		nvl(addr_sfx, ' ')	||','||

		location_no							||','||
		water_id							||','||
		rpad(parcel_id,02)					||','||
		decode (sign(y_coord - 7018580), -1, 'S', 'N')	||','||

		decode (zone, 'WEST', 'W', 'E')			||','||
		decode (basin,'ROWLETT', 'ROWL', 'DUCK')		||','||
		council_id							||','||
		fire_district
	" "
	from
(
	select distinct
		a.addr_num, a.addr_pfx, a.addr_name, a.addr_type, a.addr_sfx, 
		l.location_no, l.water_id, a.parcel_id, a.y_coord, w.zone, w.basin, p.council_id, p.fire_district
	from		garland.cdreladr		A,
			garland.cdrelpar		P,
			garland.Temp_View		L,
			garland.Temp_View1	W
	where		a.parcel_id		= p.parcel_id
	and		p.parcel_id 	= l.parcel_id
	and		a.mslink||''	= w.address_id
	and		a.addr_num <> 9999
)
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num, location_no
);

--	===========================================================================

	spool off;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert   into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;

--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Dependent;
--	===========================================================================
	set 	termout	on;
	set 	timing	off;

