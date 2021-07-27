--	==============================================================
--	update CODEADDR address & council district
--	==============================================================

--	alter rollback

	set echo		off;
	set serveroutput	on;

	select count(*) "nsa codeaddr" from nsa_codeaddr;
	select count(*) "codeaddr    " from codeaddr;

declare

		do_compile		number := 0;
		do_commit		number := 01;

		total_update	number := 0;
		total_match		number := 0;
		count_match		number := 0;
		

GIS		nsa_codeaddr%rowtype;

cursor	read_nsa_codeaddr		is
		select * from nsa_codeaddr
		where council_district > '0';

--	=================================================

begin

	if	do_compile > 0	then
		return;
	end if;

--	dbms_transaction.use_rollback_segment ('RB1');

	open	read_nsa_codeaddr;

loop

	fetch	read_nsa_codeaddr			into GIS;
	exit when	read_nsa_codeaddr%notfound
	or		read_nsa_codeaddr%notfound is null; 

	if	gis.council_district >= '1'		then
		if	do_commit > 0	then
			update  codeaddr	
			set	address_name	= gis.addr_name,
				address_type	= gis.addr_type,
				address_prefix	= gis.addr_pfx,
				address_suffix	= gis.addr_sfx,
				council_district	= gis.council_district
			where	addr_id = gis.addr_id;
			total_update := total_update + 01;
		else
			select count(*)
			into	count_match
			from	codeaddr
			where	addr_id = gis.addr_id;
			total_match  := total_match + count_match;
		end if;
	end if;

end loop;

	if	do_commit > 0	then
		commit;
	end if;

	dbms_output.put_line ( 'matches = ' || total_match );
	dbms_output.put_line ( 'updates = ' || total_update);

end;


/*

CODEADDR update	Nov 09 2001

nsa_codeaddr     
------------
     12224
1 row selected.

codeaddr    
----------
    101028
1 row selected.

matches = 0
updates = 6380

*/