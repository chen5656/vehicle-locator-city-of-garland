
/*

--	==============================================================================

--	TRIGGERS

	create or replace trigger	tst_adrname_trigger

		before	insert
		on		adrname
		for		each row

		when	(new.addr_name like 'DEACUTIS%')

		begin

			:new.addr_name := 'JOHN';
	
		end;

--	==============================================================================

	insert into adrname values ( 'DEACUTIS', '','','','','','', SYSDATE);
	commit;

--	==============================================================================


--	PRIVILEGES


	grant select on adrname to  enavarro	;

	
	select * from table_privileges	where table_name = 'ADRNAME';

--	==============================================================================

*/


	
	select * from table_privileges	where table_name = 'ADRNAME';



