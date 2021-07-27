	set echo	off;
--	===================================================================================
--	Clustering:  Likelihood that entries in leaf block point to the same table block

--	the closer clustering is to the block  count, the better
--	the closer clustering is to the record count, the worser
--	====================================================================================


	select rpad(x.table_name,25) table_name, rpad(x.index_name,25) index_name, 
			s.blocks, x.clustering_factor, x.num_rows, x.avg_data_blocks_per_key "Blocks/Key"
	from 	ind			x,
		dba_segments	s
	where	x.index_name	= s.segment_name	

	and	(
		table_name like 'CDREL%'
	or	table_name like 'TRVEH%'	
	or	table_name like 'ADR%'	
		)
	order by	1,2;


--	=================================================================
	set echo		on;


