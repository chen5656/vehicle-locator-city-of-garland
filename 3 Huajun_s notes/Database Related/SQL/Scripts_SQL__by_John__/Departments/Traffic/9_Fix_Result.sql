
	update adrResult_input
	set	addr_name = 'NORTHWEST'
	where	addr_name = 'NORTHWESTHWY';


	update adrResult_input
	set	addr_name = 'LAVON'
	where	addr_name = 'S.H.78   (LAVON)';


	update adrResult_input
	set	addr_name = 'GEORGE BUSH'
	where	addr_name = 'GEORGE BUSH (190)';


	COMMIT;
	rollback;