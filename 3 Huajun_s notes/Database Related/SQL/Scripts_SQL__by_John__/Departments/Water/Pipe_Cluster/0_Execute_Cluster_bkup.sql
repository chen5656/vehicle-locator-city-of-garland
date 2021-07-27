	set echo off;
--	====================================================================
--	PREPARATION
--	====================================================================

--	@c:\deacutis\scripts\departments\water\pipe_cluster\TRUNCATIONS.sql

--	SQL LOADER	\\LOADER\WATER_CLUSTER_PIPE.ctl
--	SQL LOADER	\\LOADER\WATER_CLUSTER_NODE.ctl
--	SQL LOADER	\\LOADER\WATER_CLUSTER_PARCEL.ctl
--	SQL LOADER	\\LOADER\WATER_CLUSTER_VALVE.ctl

--	====================================================================

	select 'DEFINE VIEWS             ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
	@c:\deacutis\scripts\departments\water\pipe_cluster\10_DEFINE_VIEWS.sql


	select 'ASSIGN VALVE NODE        ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
	@c:\deacutis\scripts\departments\water\pipe_cluster\11_ASSIGN_VALVE_NODE.sql


	select 'ASSIGN EXTERNAL DANGLE   ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
	@c:\deacutis\scripts\departments\water\pipe_cluster\12_ASSIGN_EXTERNAL_DANGLE.sql


	select 'ASSIGN NODE TYPES        ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
	@c:\deacutis\scripts\departments\water\pipe_cluster\13_ASSIGN_NODE_TYPES.sql


	select 'POPULATE PIPE PAIR       ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
	@c:\deacutis\scripts\departments\water\pipe_cluster\2_POPULATE_PIPE_PAIR.sql

--	------------------------------------------------------------------------------------------------

	select 'START PIPE GROUP      ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;

--	@c:\deacutis\scripts\departments\water\pipe_cluster\3_INITIAL_PIPE_GROUP.sql

	set timing	on;
--	@c:\deacutis\scripts\departments\water\pipe_cluster\4_POPULATE_PIPE_GROUP.sql
	set timing	off;

	select 'STOP  PIPE GROUP      ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;

--	------------------------------------------------------------------------------------------------

	select 'BUILD WATER IVR PIPE     ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
--	@c:\deacutis\scripts\departments\water\pipe_cluster\7_BUILD_WATER_IVR_PIPE.sql


	select 'BUILD WATER IVR VALVE    ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
--	@c:\deacutis\scripts\departments\water\pipe_cluster\8_BUILD_WATER_IVR_VALVE.sql


	select 'BUILD WATER IVR PARCEL   ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
--	@c:\deacutis\scripts\departments\water\pipe_cluster\9_BUILD_WATER_IVR_PARCEL..sql


	select 'QUERY CLUSTER COUNT      ' || to_char(sysdate, 'mm-dd-yyyy hh24:mi') " "	from dual;
--	@c:\deacutis\scripts\departments\water\pipe_cluster\QUERY_CLUSTER_COUNT.sql

