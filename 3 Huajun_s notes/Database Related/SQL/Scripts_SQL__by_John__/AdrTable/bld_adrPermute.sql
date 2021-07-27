
--	========================================================================
/*
	set echo off;
	
--	alter rollback segment	rb1	online;

	@c:\deacutis\scripts\adrtable\bld_adrpermute.sql;

	commit;

--	alter rollback segment	rb1	offline;
*/
--	========================================================================

	set serveroutput	on;

	truncate table	adrpermute	reuse storage;

declare

	do_compile_only	number	:= 0;

	permute_num		number;

	insert_count	number	:= 0;

begin


	if	do_compile_only > 0		then
		return;
	end if;


--	dbms_transaction.use_rollback_segment ('RB1');

--	===================================================================================

for	look in (	select distinct	
				 addr_num, addr_pfx, addr_name, addr_type, addr_sfx 	
			from 	 cdreladr   
			where  addr_num is not null
			order by 1,2,3,4,5 
		)	
loop

	permute_num	:= adr_permute_number (look.addr_num);

	insert into	adrpermute		 values 
	(look.addr_num, look.addr_pfx, look.addr_name, look.addr_type, look.addr_sfx, permute_num);

	insert_count := insert_count + 01;

end loop;

--	===================================================================================

	dbms_transaction.commit;

	dbms_output.put_line ( 'total permute numbers inserted = ' || insert_count );	

end;


