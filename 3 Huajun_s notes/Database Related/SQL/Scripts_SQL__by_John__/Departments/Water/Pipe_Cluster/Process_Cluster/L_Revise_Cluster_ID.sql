--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	================================================================================
--	Connected Pipes may have different Cluster IDs
--	If a Pipe has a Cluster ID that is higher than one or more connectd Cluster IDs
--	then look for the Lowest Cluster ID onnected to that Higher Cluster ID
--	=================================================================================
--	Take those extracted HI/LO Cluster pairs and do bulk updates
--	changing the Higher Cluster ID to the Lower Cluster ID
--	=================================================================================
--	The above TWO STEPS need to be repeated until no more Hi/Lo changes can be found.
--	At that point all the Pipes in a Cluster will have the same lowest Cluster ID
--	=================================================================================

	select sysdate || '*** Cluster ID Revision    ***' " "	from dual;

declare

	compile_only	integer	:= 0;
	insert_count	integer	:= 999;
	update_count	integer	:= 0;
	update_total	integer	:= 0;

begin

	if	compile_only > 0		then
		return;
	end if;

	while	insert_count > 0		loop

--	-------------------------------------------------------------
--	Find HiLo Pairs

		DBMS_UTILITY.EXEC_DDL_STATEMENT ('Truncate table  garland.GIS_OBJECTS  reuse storage');

		insert into garland.TEMP_VIEW
		select H.ClusterID, 
			 min(L.ClusterID)
		from	garland.WATER_IVR_PIPE_WORK	L,
			garland.WATER_IVR_PIPE_WORK	H
		where	L.NodeID1	= H.NodeID2
		and	L.ClusterID < H.ClusterID
		group by H.clusterID;
	
		insert_count := sql.rowcount;

		COMMIT;

--	-------------------------------------------------------------
--	Apply the HiLo Revision

		update garland.WATER_IVR_PIPE_WORK	P
		set	 P.ClusterID = 
	(
		select T.ClusterLO
		from	garland.TEMP_VIEW			T
		where T.ClusterHI = P.ClusterID||''
	)
		where exists
	(
		select 'x'
		from	garland.TEMP_VIEW			V
		where V.ClusterHI = P.ClusterID||''
	);

		update_count := sql.rowcount;
		update_total := update_total + update_count;

		COMMIT;

--	-------------------------------------------------------------

		dbms_output.put_line ('Cluster ID HI / LO  Count = ' || insert_count);
		dbms_output.put_line ('Cluster ID Revision Count = ' || update_count);

	end loop;

	dbms_output.put_line ('Cluster ID Revision Total = ' || update_total);

end;

--	====================================================================
