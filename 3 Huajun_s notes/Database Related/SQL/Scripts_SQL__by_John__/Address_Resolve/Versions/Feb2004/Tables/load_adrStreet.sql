--	=============================================================
--	Copy input table (adrStreets) to output table (adrStreet)
--	=============================================================

	drop synonym	syn_input_table;
	drop synonym	syn_output_table;

	create synonym	syn_input_table	for garland.ADRSTREETS;
	create synonym	syn_output_table	for garland.ADRSTREET;

--	=============================================================

	truncate table	garland.ADRSTREET		reuse storage;		--	CHANGE

--	=============================================================

--	alter rollback segment rb1	online;
--	commit;
--	set transaction use rollback segment rb1;

	insert --+  append
	into		syn_output_table
	select	all *
	from		syn_input_table;

	commit;
--	alter rollback segment rb1	offline;

	analyze table	garland.ADRSTREET		compute statistics;	--	CHANGE

--	=============================================================

