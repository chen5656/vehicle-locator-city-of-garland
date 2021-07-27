	set echo		off;
	set serveroutput	on;
--	==================================================================
--	parse unit numbers (unit) out of unit types (bldg)
--	==================================================================

declare

	here			number;
	do_update		number;
	update_total	number	:= 0;

	this_rowid		rowid;
	this_bldg1		varchar2(20);
	this_unit1		varchar2(20);
	this_bldg2		varchar2(20);
	this_unit2		varchar2(20);


cursor	read_address_unit		is
	select 
		rtrim(addr_bldg1)		addr_bldg1, 
		rtrim(addr_unit1)		addr_unit1, 
		rtrim(addr_bldg2)		addr_bldg2, 
		rtrim(addr_unit2)		addr_unit2, 
		rowid				row_id 
	from	garland.address_unit ;

--	=====================================================
begin

for look in	read_address_unit		loop

	do_update	:= 0;
	this_bldg1	:= null;
	this_unit1	:= null;
	this_bldg2	:= null;
	this_unit2	:= null;

	here	:= instr (look.addr_bldg1,' ');
	if	here > 0	
	and	nvl(look.addr_unit1,' ') < '!'			then
		this_unit1	:= ltrim(substr(look.addr_bldg1, here));
		this_bldg1	:= rtrim(rpad  (look.addr_bldg1, here));
		do_update	:= 01;
	end if;

	here	:= instr (look.addr_bldg2,' ');
	if	here > 0	
	and	nvl(look.addr_unit2,' ') < '!'			then
		this_unit2	:= ltrim(substr (look.addr_bldg2, here));
		this_bldg2	:= rtrim(rpad   (look.addr_bldg2, here));
		do_update	:= 01;
	end if;

	if	do_update > 0				then
		update garland.address_unit
		set	addr_bldg1	= nvl(this_bldg1, nvl(look.addr_bldg1,' ')),
			addr_unit1	= nvl(this_unit1, nvl(look.addr_unit1,' ')),
			addr_bldg2	= nvl(this_bldg2, nvl(look.addr_bldg2,' ')),
			addr_unit2	= nvl(this_unit2, nvl(look.addr_unit2,' '))

		where	rowid	= look.row_id;

		update_total := update_total + sql%rowcount;
	end if;

end loop;

	commit;

	dbms_output.put_line ( 'total updates = ' || update_total);

end;