	set echo	off;
--	===============================================================================================
--	build intersection table from scratch using spoke table
--	===============================================================================================

	truncate table	intersection	reuse storage;

	truncate table	gis_temp2		reuse storage;	--	nodes w/ missing spoke ids

	truncate table	gis_temp3		reuse storage;	--	Corner View

	comment on table  gis_objects		 is	'Intersection table';
	comment on table  gis_temp2		 is	'Spoke Missing IDs';
	comment on table  gis_temp3		 is	'Corner table';

--	===============================================================================================

	@c:\deacutis\scripts\intersection\11_Execute_Live.sql;	

--	@c:\deacutis\scripts\intersection\12_Execute_Test.sql;	

--	===============================================================================================

--	analyze table	intersection	compute statistics;
	analyze table	gis_objects		compute statistics;

	analyze table	gis_temp2		compute statistics;
	analyze table	gis_temp3		compute statistics;

--	===============================================================================================
	set echo	on;
