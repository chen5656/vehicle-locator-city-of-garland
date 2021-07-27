--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--				I N P U T
--	====================================================================
--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================

--	====================================================================
--	What is the Lowest Cluster ID in the same interior as a Higher Cluster ID 

	create or replace view	garland.Temp_View		as
		select	item01	ClusterHI,
				item02	ClusterLO
		from		garland.gis_objects;

--	====================================================================
