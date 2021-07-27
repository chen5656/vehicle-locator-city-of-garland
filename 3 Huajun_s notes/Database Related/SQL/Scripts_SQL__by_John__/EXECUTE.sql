
--	-------------------------------------------------------------------

	select distinct
	'  analyze table ' || t.owner ||'.'|| rpad(t.table_name,30) || ' compute statistics;'  " "
	from	all_tables			T,
(
	select table_name, owner
	from	 all_tables
--	where	 table_name in ('ADDRESS', 'ROAD', 'STREET')				--  S P E C I F Y
	where	 table_name like	'WATER%'								--  S P E C I F Y
	and	 owner = 'GARLAND'
)						F

--	------------------------------------------------------------------------------------------------------

	where	t.owner = f.owner
	and	t.table_name	IN
(
	select f.table_name	from dual

	union all
	select 'A' || r.registration_id
	from	sde.table_registry	R
	where	r.table_name = f.table_name
	and	r.owner	 = f.owner

	union all
	select 'D' || r.registration_id
	from	sde.table_registry	R
	where	r.table_name = f.table_name
	and	r.owner	 = f.owner

	union all
	select 'F' || l.layer_id
	from	sde.layers			L
	where	l.table_name = f.table_name
	and	l.owner	 = f.owner

	union all
	select 'S' || l.layer_id
	from	sde.layers			L
	where	l.table_name = f.table_name
	and	l.owner	 = f.owner
);


-------------------------------------------------------------------------------------------------
  analyze table GARLAND.F1280                          compute statistics;
  analyze table GARLAND.F1281                          compute statistics;
  analyze table GARLAND.F1283                          compute statistics;
  analyze table GARLAND.F1284                          compute statistics;
  analyze table GARLAND.F1285                          compute statistics;
  analyze table GARLAND.F1286                          compute statistics;
  analyze table GARLAND.F1287                          compute statistics;
  analyze table GARLAND.S1280                          compute statistics;
  analyze table GARLAND.S1281                          compute statistics;
  analyze table GARLAND.S1283                          compute statistics;
  analyze table GARLAND.S1284                          compute statistics;
  analyze table GARLAND.S1285                          compute statistics;
  analyze table GARLAND.S1286                          compute statistics;
  analyze table GARLAND.S1287                          compute statistics;
  analyze table GARLAND.WATER_AVL_TRACKING             compute statistics;
  analyze table GARLAND.WATER_AVL_TRACKING_TEMP        compute statistics;
  analyze table GARLAND.WATER_AVL_TRACK_HIST           compute statistics;
  analyze table GARLAND.WATER_AVL_WORKORDER            compute statistics;
  analyze table GARLAND.WATER_AVL_WORKORDER_TEMP       compute statistics;
  analyze table GARLAND.WATER_AVL_WORK_HIST            compute statistics;
  analyze table GARLAND.WATER_CITIZEN_WORKORDER        compute statistics;
  analyze table GARLAND.WATER_FITTING                  compute statistics;
  analyze table GARLAND.WATER_HYDRANT                  compute statistics;
  analyze table GARLAND.WATER_IVR_NODE_WORK            compute statistics;
  analyze table GARLAND.WATER_IVR_PARCEL               compute statistics;
  analyze table GARLAND.WATER_IVR_PIPE                 compute statistics;
  analyze table GARLAND.WATER_IVR_PIPE_WORK            compute statistics;
  analyze table GARLAND.WATER_IVR_PIPE_WORK_COPY       compute statistics;
  analyze table GARLAND.WATER_IVR_VALVE                compute statistics;
  analyze table GARLAND.WATER_METER                    compute statistics;
  analyze table GARLAND.WATER_NON_CITIZEN_VEHICLES     compute statistics;
  analyze table GARLAND.WATER_PIPE                     compute statistics;
  analyze table GARLAND.WATER_PUMP                     compute statistics;
  analyze table GARLAND.WATER_SEWER_METER_VEHICLES     compute statistics;
  analyze table GARLAND.WATER_TANK                     compute statistics;
  analyze table GARLAND.WATER_VALVE                    compute statistics;

36 rows selected.


--	-------------------------------------------------------------------

	spool off
