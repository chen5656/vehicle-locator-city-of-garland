--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	=================================================================================
--	If a Pipe is attached to an external node then its Cluster ID = its Pipe ID
--	=================================================================================

	select sysdate || '***   Initialize Cluster ID   ***'     from dual;

	update garland.Water_IVR_Pipe_Work
	set	ClusterID = PipeID
	where 'I' <> all (upper(NodeType1, upper(NodeType2))
	;

	COMMIT;

--	====================================================================
