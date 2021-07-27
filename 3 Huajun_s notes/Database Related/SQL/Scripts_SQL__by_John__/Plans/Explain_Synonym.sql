	set echo	off;
--	===================================================================
--	PLAN TABLE

	drop synonym	syn_plan_table;
	create synonym	syn_plan_table		for plan_table@gisp;
	
--	===================================================================
	
	drop synonym	syn_dba_tables;
	drop synonym	syn_dba_indexes;
	drop synonym	syn_dba_constraints;
	drop synonym	syn_dba_tab_columns;
	drop synonym	syn_dba_ind_columns;
	drop synonym	syn_dba_segments;

--	===================================================================
--	GIS
/*
	create synonym	syn_dba_tables		for dba_tables@gisp;
	create synonym	syn_dba_indexes		for dba_indexes@gisp;
	create synonym	syn_dba_constraints	for dba_constraints@gisp;
	create synonym	syn_dba_tab_columns	for dba_tab_colums@gisp;
	create synonym	syn_dba_ind_columns	for dba_ind_columns@gisp;
	create synonym	syn_dba_segments		for dba_segments@gisp;

*/
--	===================================================================
--	UMS

	create synonym	syn_dba_tables		for dba_tables@umsp.world;
	create synonym	syn_dba_indexes		for dba_indexes@umsp.world;
	create synonym	syn_dba_constraints	for dba_constraints@umsp.world;
	create synonym	syn_dba_tab_columns	for dba_tab_columns@umsp.world;
	create synonym	syn_dba_ind_columns	for dba_ind_columns@umsp.world;
	create synonym	syn_dba_segments		for dba_segments@umsp.world;

--	===================================================================
--	CODE
/*
	create synonym	syn_dba_tables		for dba_tables@cdep.world;
	create synonym	syn_dba_indexes		for dba_indexes@cdep.world;
	create synonym	syn_dba_constraints	for dba_constraints@cdep.world;
	create synonym	syn_dba_tab_columns	for dba_tab_columns@cdep.world;
	create synonym	syn_dba_ind_columns	for dba_ind_columns@cdep.world;
	create synonym	syn_dba_segments		for dba_segments@cdep.world;
*/
--	===================================================================
	set echo	on;
