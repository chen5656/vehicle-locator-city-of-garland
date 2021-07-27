--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--	Propogate Cluster ID across pipes have common interior nodes (positive)
--	===================================================================
--	Node Types
--		'V'		Valve			external node
--		'v'		Dead End		external node
--		'D'		Dangle		interior node
--	====================================================================

declare

	compile_only	integer	:= 0;
	insert_total	integer	:= 999;
	update_total	integer	:= 0;

begin

	if	compile_only > 0		then
		return;
	end if;

	while	insert_total > 0		loop

		DBMS_UTILITY.EXEC_DDL_STATEMENT ('Truncate table  garland.GIS_OBJECTS  reuse storage');

		insert into garland.TEMP_VIEW
		select H.clusterID, min(L.clusterID)
		from	garland.WATER_IVR_PIPE_WORK	L,
			garland.WATER_IVR_PIPE_WORK	H
		where	L.nodeID2	= H.nodeID1
		and	L.clusterID < H.clusterID
		group by H.clusterID;
	
		insert_total := sql.rowcount;

		COMMIT;

--	-------------------------------------------------------------

		update garland.WATER_IVR_PIPE_WORK	P
		set	 P.clusterID = 
	(
		select T.clusterLO
		from	garland.TEMP_VIEW			T
		where T.clusterHI = P.clusterID||''
	)
		where exists
	(
		select 'x'
		from	garland.TEMP_VIEW			T
		where T.clusterHI = P.clusterID||''
	);

		update_total := sql.rowcount;

		COMMIT;

		dbms_output.put_line ('Total Cluster HiLo Changes = ' || insert_total);
		dbms_output.put_line ('Total Cluster Reductions   = ' || update_total);

	end loop;
end;

--	====================================================================
