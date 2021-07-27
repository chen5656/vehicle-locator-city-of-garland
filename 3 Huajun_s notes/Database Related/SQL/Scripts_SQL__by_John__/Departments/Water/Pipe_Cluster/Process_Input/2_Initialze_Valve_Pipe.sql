--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	====================================================================
--	If a Pipe is attached to an external node then Cluster ID = Pipe ID
--	===================================================================
--	Node Types
--		'V'		Valve			external node
--		'v'		Dead End		external node
--		'D'		Dangle		interior node
--	====================================================================

	update garland.Water_IVR_Pipe_Work
	set	clusterID = pipeID
	where	0 < some (NodeID1, NodeID2);

	COMMIT;

--	====================================================================
