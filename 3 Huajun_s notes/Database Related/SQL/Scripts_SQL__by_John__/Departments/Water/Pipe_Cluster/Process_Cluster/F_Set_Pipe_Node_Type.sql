--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	====================================================================
--				I N P U T
--	====================================================================
--	A Pipe Node that is an interior node (Dangle)  is positive
--	A Pipe Node that is a Valve or Dead End should be negative.
--	A Cluster ID will not be propogated across a negative node.
--	====================================================================

--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================


	select sysdate) || '***   Set Pipe Node Type   ***' " "  from dual;

	update garland.Water_IVR_Pipe_Work		P
	set	NodeType1 = 
	( 	select NodeType	
		from	garland.Water_IVR_Node_Work	N
		where	n.NodeID 	= p.NodeID1
		and	n.Pipe_ID	= p.Pipe_ID
	);

	COMMIT;


	update garland.Water_IVR_Pipe_Work		P
	set	NodeType2 = 
	( 	select NodeType	
		from	garland.Water_IVR_Node_Work	N
		where	n.NodeID 	= p.NodeID2
		and	n.Pipe_ID	= p.Pipe_ID
	);

	COMMIT;

--	====================================================================
