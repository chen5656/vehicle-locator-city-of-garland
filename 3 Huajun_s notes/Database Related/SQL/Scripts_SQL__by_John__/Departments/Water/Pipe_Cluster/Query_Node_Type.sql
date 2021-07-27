
--	Node Type Sample

	select rpad(node_type,	  9)	node_type,
		 rpad(min(node_id), 9)	node_lo,
		 rpad(max(node_id), 9)	node_hi
	from	 garland.view_node_master
	where	 node_id <= '999999'
	group  by node_type;
