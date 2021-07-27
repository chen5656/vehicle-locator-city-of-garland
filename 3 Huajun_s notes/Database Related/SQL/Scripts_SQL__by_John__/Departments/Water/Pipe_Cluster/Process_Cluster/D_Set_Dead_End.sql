--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Set DEAD END nodes
--	Most Nodes are associated with two Pipes, since it is the connection point of the two
--	A Node that is the endpoint of only one Pipe is a Dead End
--	=====================================================================

--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================

	select sysdate || '*** Set   Dead End   ***' " "	from dual;

	update garland.Water_IVR_Node_Work
	set	NodeType = 'D'
	where	NodeID	in
(
	select NodeID
	from	garland.Water_IVR_Node_Work
	where	upper(Node_Type) = 'I'
	group by NodeID
	having count(*) = 1
);

	COMMIT;

