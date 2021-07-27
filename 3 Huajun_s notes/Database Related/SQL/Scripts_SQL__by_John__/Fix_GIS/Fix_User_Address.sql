
--	clean up the address columns in a user table

--	instructions
--	change capitalized name to desired table


--	===============================================================

	drop synonym	tmp_table_syn;
	create synonym	tmp_table_syn	for 		GARLAND.SANI_COM_FL;

	alter rollback segment	rb_large	online;

--	===============================================================

	set transaction	use rollback segment	rb_large;

--	remove (pvt) from street name

		variable	pvt_name varchar2;
		execute	:pvt_name := upper ( '(pvt)');

		update	tmp_table_syn
		set		addr_name = replace (addr_name, :pvt_name)
		where		instr (addr_name, :pvt_name ) > 0;


	commit;




	set transaction	use rollback segment	rb_large;

--	remove trailing spaces from address

		update	tmp_table_syn
		set		addr_name = rtrim (addr_name)
		where		length (addr_name) <> length (rtrim (addr_name));

		update	tmp_table_syn
		set		addr_type = rtrim (addr_type)
		where		addr_type > '0'
		and		length (addr_type) <> length (rtrim (addr_type));

		update	tmp_table_syn
		set		addr_pfx = rtrim (addr_pfx)
		where		addr_pfx > '0'
		and		length (addr_pfx) <> length (rtrim (addr_pfx));

		update	tmp_table_syn
		set		addr_sfx = rtrim (addr_sfx)
		where		addr_sfx > '0'
		and		length (addr_sfx) <> length (rtrim (addr_sfx));

	commit;



	set transaction	use rollback segment	rb_large;

--	initialize null qualifiers

		update	tmp_table_syn
		set		addr_type = ' '
		where		addr_type is null;


		update	tmp_table_syn
		set		addr_pfx = ' '
		where		addr_pfx is null;


		update	tmp_table_syn
		set		addr_sfx = ' '
		where		addr_sfx is null;

	commit;


--	===============================================================

	alter rollback segment	rb_large	offline;

--	===============================================================

