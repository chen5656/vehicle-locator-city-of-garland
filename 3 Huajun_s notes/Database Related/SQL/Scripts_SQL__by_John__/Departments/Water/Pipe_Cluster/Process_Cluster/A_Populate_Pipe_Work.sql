--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  

--	====================================================================
--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================

	select sysdate || '*** Populate Pipe Work   ***' " "	from dual;

	truncate table garland.Water_IVR_Pipe_Work  reuse storage;	

	insert --+ append
	into	garland.Water_IVR_Pipe_Work

	select
		featureid		PipeID,
		null			ClusterID,
		null			NodeType1,
		null			NodeType2,
		x1 || y1		NodeID1,
		x2 || y2		NodeID2
	from	gis.Feature_Coordinates
	where	featureclass = 'WTPI'

	UNION ALL
	select
		featureid		PipeID,
		null			ClusterID,
		null			NodeType1,
		null			NodeType2,
		x2 || y2		NodeID1,
		x1 || y1		NodeID2
	from	gis.Feature_Coordinates
	where	featureclass = 'WTPI'
	;

	COMMIT;

--	====================================================================

	select sysdate) || '***   Analyze Pipe Work   ***' " "  from dual;
	analyze table garland.Water_IVR_Pipe_Work		compute statistics;

--	====================================================================

