--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--				I N P U T
--	====================================================================
--	A Pipe Node that is an interior node (Dangle)  is positive
--	A Pipe Node that is a Valve or Dead End should be negative.
--	A Cluster ID will not be propogated across a negative node.
--	====================================================================
--	Node Types
--		'V'		Valve
--		'v'		Dead End
--		'D'		Dangle
--	====================================================================

	update garland.Water_IVR_Pipe_Work
	set	NodeID1 = - NodeID1
	when	NodeID1 in
	( 	select Node_ID 
		from	garland.Water_IVR_Node_Master
		where	Node_Type in ('V', 'v')
	);


	update garland.Water_IVR_Pipe_Work
	set	NodeID2 = - NodeID2
	when	NodeID2 in
	( 	select Node_ID 
		from	garland.Water_IVR_Node_Master
		where	Node_Type in ('V', 'v')
	);

	COMMIT;

--	====================================================================
